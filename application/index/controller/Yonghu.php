<?php
namespace app\index\controller;
use app\common\controller\Base;
use app\index\model\User;
/**
 * Class Yonghu 教学管理-用户管理
 * @package app\index\controller
 */
class Yonghu extends Base{
    //用户管理首页
    public function index(){
        $arr = User::get_list();
        $this->assign('arr',$arr);
        return $this->fetch();
    }
    //用户管理-新增
    public function add(){
        if (request()->isGet()){
            return $this->fetch();
        }elseif (request()->isPost()){
            $arr = request()->param();
            unset($arr['/index/yonghu/add']);
            $ar = model('user')
                ->save($arr);
            if ($ar){
                $this->success('新增用户成功！',url('index/yonghu/index'));
            }else{
                $this->error('新增用户失败！',url('index/yonghu/add'));
            }
        }
    }

    //用户管理-删除
    public function del(){
        $id =request()->param()['id'];
        $del = model('user')
            ->where('id',$id)
            ->delete();
        if ($del){
            $this->success('删除成功！',url('index/yonghu/index'));
        }else{
            $this->error('删除失败',url('index/yonghu/index'));
        }
    }


}