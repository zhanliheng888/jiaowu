<?php
namespace app\index\controller;
use app\common\controller\Base;
use app\index\model\Jiaoshi as jiao;
/**
 * Class Jiaoshi 教学管理-教师管理
 * @package app\index\controller
 */
class Jiaoshi extends Base{
    // 教师管理首页
    public function index(){
        $arr = jiao::get_list();
        $this->assign('arr',$arr);
        return $this->fetch();
    }

    //教师详情
    public function detail(){
        $id = request()->param()['id'];
        $arr = jiao::get_list($id);
        $this->assign('arr',$arr);
        return $this->fetch();
    }

    //教师管理-新增
    public function add(){
        if (request()->isGet()){
            $list = model('xueyuan')
                ->field('id,xiname')
                ->select();
            $li = model('kecheng')
                ->field('id,kname')
                ->select();
            $this->assign('list',$list);
            $this->assign('li',$li);
            return $this->fetch();
        }elseif (request()->isPost()){
            $arr = request()->param();
            unset($arr['/index/jiaoshi/add']);
            $img = request()->file('jpg');      //获取上传的文件
            $questionName = $_FILES["jpg"]["name"];
            $filename = substr(strrchr($questionName, "."),1);//获取文件类型
            if ($filename == 'jpg'||$filename == 'png'||$filename == 'jpeg'){
                $info = $img->move('static/img');     //移动到指定目录
                if ($info){
                    //获取文件名称
                    $exclePath = $info->getsaveName();  //获取文件路径
                    $arr['jpg'] = $exclePath;
                    $ar = model('jiaoshi')
                        ->save($arr);
                    if ($ar){
                        $this->success('新增成功！',url('index/jiaoshi/index'));
                    }else{
                        $this->error('新增失败！',url('index/jiaoshi/add'));
                    }
                }else{
                    $this->error('文件上传失败！',url('index/jiaoshi/add'));
                }

            }else{
                $this->error('文件上传格式只支持jpg png格式！',url('index/jiaoshi/add'));
            }
        }
    }

}