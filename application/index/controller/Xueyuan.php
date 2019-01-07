<?php
namespace app\index\controller;
use app\common\controller\Base;

/**
 * Class Xueyuan  教学管理-学院管理
 * @package app\index\controller
 */
class Xueyuan extends Base{
    //学院管理展示
    public function index(){
        $arr = model('xueyuan')
            ->paginate(15);
        //print_r($arr);die();
        $this->assign([
            'arr'=>$arr,
        ]);
        return $this->fetch();
    }

    //学院管理详情
    public function detail(){
        $id = request()->param()['id'];
        $arr = model('xueyuan')
            ->where('id',$id)
            ->find();
        $this->assign('arr',$arr);
        return $this->fetch();

    }

    //新建院系
    public function add(){
        if (request()->isGet()){
            return $this->fetch();
        }elseif (request()->isPost()){
            $arr = request()->param();
            unset($arr['/index/xueyuan/add']);
            $ar = model('xueyuan')
                ->save($arr);
            //判断是否成功
            if ($ar){
                $this->success('新增成功！',url('index/xueyuan/index'));
            }else{
                $this->error('新增失败！',url('index/xueyuan/add'));
            }
        }

    }

}