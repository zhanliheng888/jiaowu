<?php
namespace app\index\controller;
use app\common\controller\Base;

/**
 * Class Index 管理系统首页
 * @package app\index\controller
 */
class Index extends Base
{
    public function index()
    {
        return $this->fetch();
    }
}
