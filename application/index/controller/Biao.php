<?php
namespace app\index\controller;
use app\common\controller\Base;

/**
 * Class Biao 成绩统计-表格统计
 * @package app\index\controller
 */
class Biao extends Base{
    //表格统计首页
    public function index(){
        //判断前端传的参数
        $arrs = request()->param();
        $where = [];
        if (isset($arrs['zhuan']) && !empty($arrs['zhuan'])){
            $where = "z.yename like '%{$arrs['zhuan']}%'";
        }
        if (isset($arrs['ke']) && !empty($arrs['ke'])){
            $where = "k.kname like '%{$arrs['ke']}%'";
        }
        if (isset($arrs['jiao']) && !empty($arrs['jiao'])){
            $where = "j.jname like '%{$arrs['jiao']}%'";
        }
        if (isset($arrs['xue']) && !empty($arrs['xue'])){
            $where = "s.sname like '%{$arrs['xue']}%'";
        }
        if (isset($arrs['li']) && !empty($arrs['li'])){
            switch ($arrs['li']){
                case 1:
                    $li = 's.xuehao';
                    break;
                case 2:
                    $li = 'c.chengji';
                    break;
            }
        }else{
            $li = 's.xuehao';
        }
        //var_dump($arrs);die();
        //获取成绩
        $arr = model('chengji')
            ->alias('c')
            ->field('c.*,u.xjid,s.xuehao,s.sname,j.jname,j.kid,k.kname,k.zid,z.yename')
            ->join('user u','c.uid=u.id')
            ->join('student s','s.id=u.xjid')
            ->join('jiaoshi j','j.id=u.xjid')
            ->join('kecheng k','k.id=j.kid')
            ->join('zhuanye z','z.id=k.zid')
            ->order("$li desc")
            ->where($where)
            ->select();

        $list = model('chengji')
            ->order('chengji desc')
            ->paginate(3);
        //var_dump($arr);die();
        $this->assign('list',$list);
        $this->assign('li',$li);
        $this->assign('arr',$arr);
        return $this->fetch();
    }
}