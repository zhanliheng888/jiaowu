<?php
namespace app\index\controller;
use app\common\controller\Base;
use app\index\model\Question as que;
use app\index\model\Lianxi as lian;
use app\index\model\Kaoshi as kao;
/**
 * Class Kaoshi 考试管理-在线考试
 * @package app\index\controller
 */
class Kaoshi extends Base{
    //在线考试首页
    public function index(){
        $arr = model('kaoshi')
            ->alias('k')
            ->field('k.*,u.xjid,j.jname')
            ->join('user u','u.id=k.uid')
            ->join('jiaoshi j','j.id=u.xjid')
            ->where('k.del',1)
            ->select();
        $a = [1,2,3,4,5];
        //判断考试时间是否结束
        foreach ($arr as $k=>$v){
            if (time()-strtotime($v->jietime) > 0){
                model('kaoshi')
                    ->where('id',$v->id)
                    ->update(['state'=>2]);
            }
        }
        $this->assign('a',$a);
        $this->assign('arr',$arr);
        return $this->fetch();
    }
    //新增考试
    public function add(){
        if (request()->isGet()){
            $uid = session('admin.id');
            $this->assign('uid',$uid);
            return $this->fetch();
        }elseif(request()->isPost()){
            $arr = request()->param();
            unset($arr['/index/kaoshi/add']);
            //获取题目
            $list['dans'] = que::get_num($arr['dan'],2,1); //单选
            $list['duos'] = que::get_num($arr['duo'],2,2); //多选
            $list['pans'] = que::get_num($arr['pan'],2,3); //判断
            $list['tians'] = que::get_num($arr['tian'],2,4); //填空
            //var_dump($list['dans']);die();
            //获取时间
            switch ($arr['kaitime']){
                case 1:
                    $arrs['kaitime'] = date('Y-m-d H:i:s',time());
                    break;
                case 2:
                    $arrs['kaitime'] = date('Y-m-d H:i:s',time()+3600*2);
                    break;
                case 3:
                    $arrs['kaitime'] = date('Y-m-d H:i:s',time()+3600*6);
                    break;
                case 4:
                    $arrs['kaitime'] = date('Y-m-d H:i:s',time()+3600*24);
                    break;
            }

            switch ($arr['jietime']){
                case 1:
                    $arrs['jietime'] = date('Y-m-d H:i:s',strtotime($arrs['kaitime'])+3600);
                    break;
                case 2:
                    $arrs['jietime'] = date('Y-m-d H:i:s',strtotime($arrs['kaitime'])+5400);
                    break;
                case 3:
                    $arrs['jietime'] = date('Y-m-d H:i:s',strtotime($arrs['kaitime'])+3600*2);
                    break;
            }
            $ar = model('kaoshi')
                ->save([
                    'uid'=>$arr['uid'],
                    'timu'=>serialize($list),
                    'kaitime'=>$arrs['kaitime'],
                    'jietime'=>$arrs['jietime']
                ]);
            if ($ar){
                $this->success('新增考试成功！',url('index/kaoshi/index'));
            }else{
                $this->success('新增考试失败！',url('index/kaoshi/add'));
            }
        }
    }

    //学生在线考试
    public function detail(){
        if (request()->isGet()){
            $id = request()->param()['id'];
            //判断考试是否过期
            $kao = model('kaoshi')
                ->where('id',$id)
                ->find();
            //考试时间
            $t = (strtotime($kao->jietime)-strtotime($kao->kaitime))/60;

            if (time()-strtotime($kao->jietime) > 0){
                $this->error('考试已结束','index/kaoshi/index');
            }
            //判断是否答题
            $dati = model('chengji')
                ->where('uid',session('admin.id'))
                ->where('kaoid',$id)
                ->find();
            if ($dati){
                $this->error('您已参加过考试！',url('index/kaoshi/index'));
            }
            $arr = model('kaoshi')
                ->where('id',$id)
                ->find();
            $time = (strtotime($arr['jietime'])-strtotime($arr['kaitime'])).'000'; //题目过时提交时间
            //获取题目
            $timu = unserialize($arr['timu']);
            $dan = model('question')
                ->where('id','in',$timu['dans'])
                ->select();
            $duo = model('question')
                ->where('id','in',$timu['duos'])
                ->select();
            $pan = model('question')
                ->where('id','in',$timu['pans'])
                ->select();
            $tian = model('question')
                ->where('id','in',$timu['tians'])
                ->select();

            $this->assign([
                'dan'=>$dan,
                'duo'=>$duo,
                'pan'=>$pan,
                'tian'=>$tian,
                'time'=>$time,
                'arr'=>$arr,
                't'=>$t
            ]);
            return $this->fetch();
        }elseif (request()->isPost()){
            $arr = request()->param();
            $id = $arr['idd'];
            unset($arr['/index/kaoshi/detail/id/detail']);
            unset($arr['id']);
            unset($arr['idd']);
            //获取学生答案
            $dans = lian::get_answer($arr,20,'dan'); //获取学生单选题目答案
            $duos = lian::get_answer($arr,10,'duo'); //获取学生多选题目答案
            //将数组变为字符串
            foreach ($duos as $k=>$v){
                if (is_array($v)){
                    $duos[$k]=rtrim(implode('/',$v),'/');
                }else{
                    $duos[$k]=$v;
                }
            }

            $pans = lian::get_answer($arr,5,'pan'); //获取学生判断题目答案
            $tians = lian::get_answer($arr,5,'tian'); //获取学生判断题目答案
            //获取题目答案
            $list = model('kaoshi')
                ->where('id',$id)
                ->find();
            $timu = unserialize($list['timu']);
            //单选
            $dan = model('question')
                ->where('id','in',$timu['dans'])
                ->select();
            foreach ($dan as $k=>$v){
                $danss[] = $v->answer;
            }
            $dansf = kao::get_fen($danss,$dans,2);
            //多选
            $duo = model('question')
                ->where('id','in',$timu['duos'])
                ->select();
            foreach ($duo as $k=>$v){
                $duoss[] = $v->answer;
            }
            $duosf = kao::get_fen($duoss,$duos,4);
            //判断
            $pan = model('question')
                ->where('id','in',$timu['pans'])
                ->select();
            foreach ($pan as $k=>$v){
                $panss[] = $v->answer;
            }
            $pansf = kao::get_fen($panss,$pans,2);
            //填空
            $tian = model('question')
                ->where('id','in',$timu['tians'])
                ->select();
            foreach ($tian as $k=>$v){
                $tianss[] = $v->answer;
            }
            $tiansf = kao::get_fen($tianss,$tians,2);
            //计算总成绩
            $zong = $dansf+$duosf+$pansf+$tiansf;

            $c = model('chengji')
                ->where('uid',session('admin.id'))
                ->find();
            if (empty($c)){
                $ar = model('chengji')
                    ->save([
                        'uid'=>session('admin.id'),
                        'kaoid'=>$id,
                        'chengji'=>$zong,
                        'type'=>1
                    ]);
            }else{
                $ar = model('chengji')
                    ->where('uid',session('admin.id'))
                    ->update([
                        'chengji'=>$zong,
                        'kaoid'=>$id,
                    ]);
            }


            if ($ar){
                $this->success('考试提交成功！',url('index/kaoshi/index'));
            }else{
                $this->error('考试提交失败！',url('index/kaoshi/detail',['id'=>$id]));
            }

        }
    }

    //删除考试
    public function del(){
        $id = request()->param()['id'];
        //逻辑删除
        $del = model('kaoshi')
            ->where('id',$id)
            ->update(['del'=>2]);
        if ($del){
            $this->success('删除成功!',url('index/kaoshi/index'));
        }else{
            $this->error('删除失败！',url('index/kaoshi/idnex'));
        }

    }

}