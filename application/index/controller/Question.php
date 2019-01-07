<?php
namespace app\index\controller;
use app\common\controller\Base;
use app\index\model\Question as que;
/**
 * Class Question 考试管理-题库管理
 * @package app\index\controller
 */
class Question extends Base{
    //题库管理首页
    public function index(){
        $arr = que::get_arr(); //仅供练习
        $list = que::get_list(); //仅供考试
        $this->assign([
            'arr'=>$arr,
            'list'=>$list
        ]);
        return $this->fetch();
    }
    //题库管理-详情
    public function detail(){
        $id = request()->param()['id'];
        $arr = model('question')
            ->where('id',$id)
            ->find();
        $this->assign('list',$arr);
        return $this->fetch();
    }
    //题目管理-新增
    public function add(){
        if (request()->isGet()){
            $list = model('kecheng')
                ->field('id,kname')
                ->select();
            $this->assign('list',$list);
            return $this->fetch();
        }elseif (request()->isPost()){
            $arr = request()->param();
            unset($arr['/index/question/add']);
            $ar = model('question')
                ->save($arr);
            if ($ar){
                $this->success('新增题目成功！',url('index/question/index'));
            }else{
                $this->error('新增题目失败！',url('index/question/add'));
            }
        }

    }


}