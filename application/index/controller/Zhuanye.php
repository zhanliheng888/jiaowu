<?php
namespace app\index\controller;
use app\common\controller\Base;
use app\index\model\Zhuanye as zhuan;

/**
 * Class Zhuanye 教学管理-专业管理
 * @package app\index\controller
 */
class Zhuanye extends Base{
    //专业管理首页
    public function index(){
        $arr = zhuan::get_list();
        $this->assign('arr',$arr);
        return $this->fetch();
    }

    //专业管理-详情查看
    public function detail(){
        $id = request()->param()['id'];
        $arr = zhuan::get_list($id);
        $this->assign('arr',$arr);
        return $this->fetch();
    }

    //专业管理-新增
    public function add(){
        if (request()->isGet()){
            $list = model('xueyuan')
                ->field('id,xiname')
                ->select();
            $this->assign('list',$list);
            return $this->fetch();
        }elseif (request()->isPost()){
            $arr = request()->param();
            unset($arr['/index/zhuanye/add']);
            $ar = model('zhuanye')
                ->save($arr);
            //判断是否新增成功
            if ($ar){
                $this->success('新增成功！',url('index/zhuanye/index'));
            }else{
                $this->error('新增失败！',url('index/zhuanye/add'));
            }
        }

    }

}