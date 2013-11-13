# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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