# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
 require 'exts'
if Role.count == 0
  Role.create([
    {name: '学生', en_name: 'student'},
    {name: '教师', en_name: 'teacher'},
    {name: '管理员（教育局）', en_name: 'admin_jyj'},
    {name: '管理员（校领导）', en_name: 'admin_xld'}
  ])
end

if Course.count == 0
  Course.create([
    {name: '语文'},
    {name: '数学'},
    {name: '英语'},
    {name: '自然'}
  ])
end

if School.count == 0
  School.create([
    {name: '青年路小学'},
    {name: '三晋小学'},
    {name: '狄村小学'},
    {name: '双塔北路小学'}
  ])
end

if User.where(email: 'admin@admin.com').size ==  0
  User.create([
    {real_name: 'admin', login: 'admin', email: 'admin@admin.com', password: '11112222', password_confirmation: '11112222'}
  ])
end

if Grade.count == 0
  1.upto(5).each do |gn|
    1.upto(5).each do |cn|
      Grade.create(grade_num: gn, class_num: cn)
    end
  end
  GradeStudent.delete_all
  GradesCourse.delete_all
end

Settings.grades = [1,2,3,4,5] if Settings.grades.nil?
Settings.classes = [1,2,3,4,5] if Settings.classes.nil?
Settings.homework_status = %w(未批阅 待改错 已改错 已完成) if Settings.homework_status.nil?
Settings.homework_levels = %w(优 良 中 差) if Settings.homework_levels.nil?
Settings.message_types = %w(system p2p apply_grades apply_courses) # if Settings.message_types.nil?

Grade.where(school_id: nil).each do |g|
  g.update_attribute :school_id, School.first.id
end

if Role.find_by_en_name('admin_xld').id  > Role.find_by_en_name('admin_jyj').id
  Role.find_by_en_name('admin_xld').update_attributes(name: '管理员（教育局）', en_name: 'admin_jyj')
  Role.find_by_en_name('admin_jyj').update_attributes(name: '管理员（校领导）', en_name: 'admin_xld')
  User.where(email: 'admin@admin.com').last.update_attribute :school_id, nil
end

if BookCategory.all.all?{|b| b.grade_num.nil?}
  BookCategory.all.each do |g|
    App::ChineseNum.each_with_index do |n, i| g.update_attribute :grade_num, i if g.name.include?(n) end
  end
end

if GradesCourse.all.all?{|b| b.book_id.nil?}
  GradesCourse.destroy_all 
  Lesson.destroy_all 
  Homework.destroy_all 
end

