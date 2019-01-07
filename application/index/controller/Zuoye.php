<?php
namespace app\index\controller;
use app\common\controller\Base;
use app\index\model\Lianxi as lian;
use app\index\model\Question as que;

/**
 * Class Zuoye 考试管理-作业
 * @package app\index\controller
 */
class Zuoye extends Base{
    //作业首页
    public function index(){
        $type = session('admin.type');
        $xjid = session('admin.xjid');
        if ($type == 1){
            $arr = model('student')
                ->alias('s')
                ->field('s.*,b.bname,b.zid,z.yename')
                ->join('banji b','b.id=s.bid')
                ->join('zhuanye z','b.zid=z.id')
                ->where('s.id',$xjid)
                ->find();
            $vv = model('user')
                ->where('xjid',$xjid)
                ->where('type',1)
                ->find();
            $uid = $vv->id;
            $list = model('zuoye')
                ->where('uid',$uid)
                ->find();

        }else{
            $arr = model('student')
                ->alias('s')
                ->field('s.*,b.bname,b.zid,z.yename,u.id as uid')
                ->join('banji b','b.id=s.bid')
                ->join('zhuanye z','b.zid=z.id')
                ->join('user u','u.xjid=s.id')
                ->where('u.type',1)
                ->select();

            foreach ($arr as $k=>$v){
                $uid[] = $v->uid;
            }
            $list = model('zuoye')
                ->where('uid','in',$uid)
                ->select();
        }

        //var_dump($list);die();
        $this->assign('arr',$arr);
        $this->assign('list',$list);
        return $this->fetch();
    }
    //布置作业
    public function add(){
        if (request()->isGet()){
            $list = model('kecheng')
                ->select();
            $xjid = request()->param()['id'];
            $vv = model('user')
                ->where('xjid',$xjid)
                ->where('type',1)
                ->find();
            $uid = $vv->id;
            $this->assign('list',$list);
            $this->assign('uid',$uid);
            return $this->fetch();
        }elseif (request()->isPost()){
            $arr = request()->param();
            $time = date("Y-m-d H:i:s",time());
            unset($arr['/index/zuoye/add/id/add']);
            unset($arr['id']);
            $list['dans'] = que::get_num($arr['dan'],3,1); //单选
            $list['duos'] = que::get_num($arr['duo'],3,2); //多选
            $list['pans'] = que::get_num($arr['pan'],3,3); //判断
            $list['tians'] = que::get_num($arr['tian'],3,4); //填空
            //完成时间
            switch ($arr['guitime']){
                case 1:
                    $gui = date('Y-m-d H:i:s', time()+86400);
                    break;
                case 2:
                    $gui = date('Y-m-d H:i:s', time()+86400*2);
                    break;
                case 3:
                    $gui = date('Y-m-d H:i:s', time()+86400*3);
                    break;

            }
            $ar['uid'] = $arr['uid'];
            $ar['timu'] = serialize($list);
            $ar['nowtime'] = $time;
            $ar['guitime'] = $gui;
            $zuo = model('zuoye')
                ->where('uid',$arr['uid'])
                ->find();
            if ($zuo){
                $a = model('zuoye')
                    ->where('uid',$arr['uid'])
                    ->update($ar);
                if ($a){
                    model('zuoye')
                        ->where('uid',$arr['uid'])
                        ->update(['have'=>1]);

                    $this->success('布置作业成功！',url('index/zuoye/index'));
                }else{
                    $this->error('布置作业失败！',url('index/zuoye/add'));
                }
            }else{
                $a = model('zuoye')
                    ->save($ar);
                if ($a){
                    model('zuoye')
                        ->where('uid',$arr['uid'])
                        ->update(['have'=>1]);
                    $this->success('布置作业成功！',url('index/zuoye/index'));
                }else{
                    $this->error('布置作业失败！',url('index/zuoye/add'));
                }
            }
        }
    }
    //学生作业
    public function detail(){
        if (request()->isGet()){
            $uid = request()->param()['uid'];
            $arr = model('zuoye')
                ->where('uid',$uid)
                ->find();
            //判断是否超时
            $time = strtotime($arr['nowtime']); //布置作业时间
            $guitime = strtotime($arr['guitime']); //规定时间

            if (time()-$time >= $guitime){
                $this->error('作业时间已经过期！',url('index/zuoye/index'));
            }
            //获取题目
            $timu = unserialize($arr['timu']);
            //单选题
            $dan = model('question')
                ->where('id','in',$timu['dans'])
                ->select();
            //多选题
            $duo = model('question')
                ->where('id','in',$timu['duos'])
                ->select();
            //判断题
            $pan = model('question')
                ->where('id','in',$timu['pans'])
                ->select();
            //填空题
            $tian = model('question')
                ->where('id','in',$timu['tians'])
                ->select();
            $this->assign([
                'arr'=>$arr,
                'dan'=>$dan,
                'duo'=>$duo,
                'pan'=>$pan,
                'tian'=>$tian
            ]);
            return $this->fetch();
        }elseif (request()->isPost()){
            $arr = request()->param();
            $uid = $arr['uuid'];
            unset($arr['/index/zuoye/detail/uid/detail']);
            unset($arr['uid']);
            unset($arr['uuid']);
            $arrs = serialize($arr); //用户答案
            //将用户答案保存到数据库
            $ar = model('zuoye')
                ->where('uid',$uid)
                ->update(['daan'=>$arrs]);
            if ($ar){
                model('zuoye')
                    ->where('uid',$uid)
                    ->update(['have'=>2]);
                $this->success('作业提交成功!',url('index/zuoye/index'));
            }else{
                $this->error('作业提交失败！',url('index/zuoye/detail',['uid'=>$uid]));
            }


        }

    }

}