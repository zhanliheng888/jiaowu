<?php
namespace app\index\controller;
use app\common\controller\Base;
use app\index\model\Kecheng as kechen;
/**
 * Class Kecheng 教学系统-课程管理
 * @package app\index\controller
 */
class Kecheng extends Base{
    //课程管理首页
    public function index(){
        $arr = kechen::get_list();
        $this->assign('arr',$arr);
        return $this->fetch();
    }
    //课程管理详情页
    public function detail(){
        $id = request()->param()['id'];
        $arr = kechen::get_list($id);
        $this->assign('arr',$arr);
        return $this->fetch();
    }

    //课程新增
    public function add(){
        if (request()->isGet()){
            $list = model('zhuanye')
                ->field('id,yename')
                ->select();
            $this->assign('list',$list);
            return $this->fetch();
        }elseif(request()->isPost()){
            $arr = request()->param();
            unset($arr['/index/kecheng/add']);
            $img = request()->file('kmian');      //获取上传的文件
            $questionName = $_FILES["kmian"]["name"];
            $filename = substr(strrchr($questionName, "."),1);//获取文件类型
            if ($filename == 'jpg'||$filename == 'png'||$filename == 'jpeg'){
                $info = $img->move('static/img');     //移动到指定目录
                if ($info){
                    //获取文件名称
                    $exclePath = $info->getsaveName();  //获取文件路径
                    $arr['kmian'] = $exclePath;
                    $ar = model('kecheng')
                        ->save($arr);
                    if ($ar){
                        $this->success('新增成功！',url('index/kecheng/index'));
                    }else{
                        $this->error('新增失败！',url('index/kecheng/add'));
                    }
                }else{
                    $this->error('文件上传失败！',url('index/kecheng/add'));
                }

            }else{
                $this->error('文件上传格式只支持jpg png格式！',url('index/kecheng/add'));
            }

        }
    }

}