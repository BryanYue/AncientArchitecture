//
//  api.h
//  AncientArchitecture
//
//  Created by bryan on 2018/3/25.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#ifndef api_h
#define api_h

//获取顶部轮播图
#define url_getCarouselImg             @"/api/Document/getCarouselImg"




//发送短信验证码   验证码类型,R:注册 S:重置密码,E:修改密码,P:修改绑定手机 【必填】
#define url_SendSms             @"/api/Index/sendSms"
//用户注册
#define url_Register            @"/api/Index/register"
//登录
#define url_Login               @"/api/Index/login"

//微信登录
#define url_wxLogin               @"/api/index/wxLogin"





//退出
#define url_signout             @"/api/Index/signout"
//获取个人信息
#define url_getUserInfo         @"/api/Member/getUserInfo"
//上传头像
#define url_uploadPhoto         @"/api/Member/uploadPhoto"
//修改用户名称
#define url_editName            @"/api/Member/editName"

//修改个人职位
#define url_editPosition        @"/api/Member/editPosition"

//会员性别修改
#define url_editSex             @"/api/Member/editSex"

// 修改个人简介
#define url_editDescibre        @"/api/Member/editDescibre"




//获取讲师课程
#define url_getTeacheCourse        @"/api/Teacher/getTeacheCourse"
//获取课程各级分类
#define url_getCategory        @"/api/Document/getCategory"

//获取分类下所有课程
#define url_getAllCourseList        @"/api/Document/getAllCourseList"

//根据课程分类id获取当前分类下的课程
#define url_getCateCourseDetail      @"/api/Document/getCateCourseDetail"

//获取课程详情
#define url_getCourseDetail        @"/api/Document/getCourseDetail"

//创建课程
#define url_creatCourse       @"/api/Document/creatCourse"

//课程图片上传
#define url_uploadImg       @"/api/Document/uploadImg"


//获取讲师详情
#define url_getTeacher      @"/api/Document/getTeacher"

//获取教师列表
#define url_getAllTeacher      @"/api/Document/getAllTeacher"

//关注讲师 type 1:关注;0:取消
#define url_teacherCollect      @"/api/Collection/teacherCollect"

//关注课程 type 1:关注;0:取消
#define url_courseCollect      @"/api/Collection/courseCollect"

//关注讲师列表
#define url_getFollowTeacher      @"/api/Document/getFollowTeacher"

//关注课程列表
#define url_getFollowCourse     @"/api/Document/getFollowCourse"

//获取热门教师
#define url_getHotTeacher      @"/api/Document/getHotTeacher"




//获取热播课程
#define url_getHotCourse     @"/api/Document/getHotCourse"

//获取课程列表 1：直播；2:预播；3：点播
#define url_allCourse      @"/api/Document/allCourse"


//获取会员购买的课程【订单列表】
#define url_buyCourse     @"/api/Member/buyCourse"

//课程搜索
#define searchCourse     @"/api/Document/searchCourse"



#endif /* api_h */
