<?php
namespace app\index\controller;
use app\common\controller\Base;

/**
 * Class Tong 成绩统计-图形统计
 * @package app\index\controller
 */
class Tong extends Base{
    //学生/课程统计表
    public function index(){
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
            ->field('c.*,u.xjid,s.bid,s.sname,b.bname,j.kid,k.kname')
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
            foreach ($arr as $k=>$v){
                $li[$k]['country'] = $v->sname;
                $li[$k]['visits'] = $v->chengji;
                $li[$k]['color'] = "#FF0F00";
            }
        }

        //var_dump($li);die();


        $ccc = json_encode($li);
        //var_dump($li);die();
        $this->assign('li',$kname);
        $this->assign('ke',$kecheng);
        $this->assign('cc',$ccc);
        $this->assign('arr',$arr);
        return $this->fetch();
    }
}