<?php
namespace app\common\controller;
use think\Controller;

/*
 * 管理控制器后台基类
 */
class Base extends Controller{
    /*
     * 初始化方法
     */
    protected function _initialize(){
        if (!session('?admin')){
            $this->redirect('index/user/login');
        }
        $module = request()->controller();
        $this->assign('module',$module);
    }
}