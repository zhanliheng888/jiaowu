<?php
namespace app\index\controller;
use app\common\controller\Base;

/**
 * Class Tu 成绩统计-图形统计
 * @package app\index\controller
 */
class Tu extends Base{
    //课程班级平均分统计首页
    public function index(){
        //班级
        $ban = model('banji')
            ->select();
        //课程
        $kecheng = model('kecheng')
            ->select();
        $pp = $kecheng[0]->kname;//课程名称
        $arrs = request()->param();

        if (isset($arrs['kname']) && !empty($arrs['kname'])){
            $where = ['k.kname'=>$arrs['kname']];
            $kname = $arrs['kname'];
        }else{
            $where = ['k.kname'=>$pp];
            $kname = '';
        }

        $arr = model('chengji')
            ->alias('c')
            ->field('c.*,u.xjid,s.bid,s.sname,b.bname,j.jname,j.kid,k.kname')
            ->join('user u','c.uid=u.id')
            ->join('student s','s.id=u.xjid')
            ->join('banji b','b.id=s.bid')
            ->join('jiaoshi j','j.id=u.xjid')
            ->join('kecheng k','k.id=j.kid')
            ->where($where)
            ->select();

        if (empty($arr)){
            $li[]['country'] ='';
            $li[]['visits'] = '';
            $li[]['color'] = "";
        }else{
            foreach ($ban as $k=>$v){
                $bans[] = $v->bname;
            }
            foreach ($arr as $k=>$v){
                $pin[] = $v->chengji;
                if (in_array($v->bname,$bans)){
                    foreach ($bans as $k=>$vv){
                        if ($vv == $v->bname){

                            $bansf[][$vv][] = $v->chengji;
                        }
                    }
                }
            }
            //平均分和最大分
            foreach ($bansf as $k=>$v){
                foreach ($v as $kk=>$vv){
                    $list[$k]['country'] = $kk.'平均值';
                    $list[$k]['visits'] = array_sum($vv)/count($vv);
                    $list[$k]['color'] = "#FF0F00";
                }

            }
            foreach ($bansf as $k=>$v){
                foreach ($v as $kk=>$vv){
                    $lists[$k]['country'] = $kk.'最大值';
                    $lists[$k]['visits'] = max($v);
                    $lists[$k]['color'] = "#FF6600";
                }
            }
            //组合成符合的json形式
            foreach ($list as $k=>$v){
                foreach ($lists as $kk=>$vv){
                    if ($k == $kk){
                        $li[] = $v;
                        $li[] = $vv;
                    }
                }
            }
        }

        //var_dump($list);die();


        $ccc = json_encode($li);
        //var_dump($li);die();
        $this->assign('li',$kname);
        $this->assign('ke',$kecheng);
        $this->assign('cc',$ccc);
        $this->assign('arr',$arr);
        return $this->fetch();
    }
}