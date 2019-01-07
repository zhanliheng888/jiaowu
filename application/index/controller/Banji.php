<?php
namespace app\index\controller;
use app\common\controller\Base;
use app\index\model\Banji as ban;
use app\index\model\Student;
/**
 * Class Banji 课程管理-班级学生管理
 * @package app\index\controller
 */
class Banji extends Base{
    //班级管理首页
    public function index(){
        $arr = ban::get_list();
        $this->assign('arr',$arr);
        return $this->fetch();
    }
    //班级管理-新增
    public function add(){
        if (request()->isGet()){
            $list = model('zhuanye')
                ->field('id,yename')
                ->select();
            $this->assign('list',$list);
            return $this->fetch();
        }elseif (request()->isPost()){
            $arr = request()->param();
            unset($arr['/index/banji/add']);
            $ar = model('banji')
                ->save($arr);
            if ($ar){
                $this->success('新增班级成功！',url('index/banji/index'));
            }else{
                $this->error('新增班级失败！',url('index/banji/add'));
            }
        }
    }
    //学生管理首页
    public function detail(){
        $id = request()->param()['id'];
        $arr = Student::get_list($id);
        $this->assign('arr',$arr);
        return $this->fetch();
    }
    //学生管理-新增
    public function adds(){
        if (request()->isGet()){
            $list = model('banji')
                ->field('id,bname')
                ->select();
            $this->assign('list',$list);
            return $this->fetch();
        }elseif (request()->isPost()){
            $arr = request()->param();
            unset($arr['/index/banji/adds']);
            $ar = model('student')
                ->save($arr);
            if ($ar){
                $this->success('新增学生成功！',url('index/banji/detail',['id'=>$arr['bid']]));
            }else{
                $this->error('新增学生失败！',url('index/banji/adds'));
            }
        }
    }
    //学生管理-删除
    public function del(){
        $id = request()->param()['id'];
        $bid = request()->param()['bid'];
        $del = model('student')
            ->where('id',$id)
            ->delete();
        if ($del){
            $this->success('删除成功！',url('index/banji/detail',['id'=>$bid]));
        }else{
            $this->error('删除失败',url('index/banji/detail',['id'=>$bid]));
        }
    }

}