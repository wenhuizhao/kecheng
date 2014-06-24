# -*- encoding : utf-8 -*-
class StudentClassroomwork < ActiveRecord::Base
  attr_accessible :classroomwork_id, :status, :student_id, :score, :level, :times, :first_update

  belongs_to :classroomwork
  belongs_to :student, class_name: 'User'
  has_many :student_classroomworks_exercises, class_name: "StudentClassroomworksExercises"
  has_and_belongs_to_many :exercises, join_table: 'student_classroomworks_exercises'

  before_create :set_status
  # validates :level, presence: true

  # scope :one_day, -> {where("student_homeworks.updated_at < #{1.days.from(created_at})")}
  scope :joins_opts, -> (opts) {joins(classroomwork: {grades_course: :grade}).where(opts.join(' and '))}
  scope :need_check, -> {where("status in ('未批阅', '已改错')")}

  PNGS = {
      "优" => "you",
      "良" => "liang",
      "中" => "zhong",
      "差" => "cha"
  }

  def png
    PNGS[level]
  end

  def set_status
    self.status = Settings.homework_status.first
  end

  def status_name
    return '完成' if self.status == '已完成'
    return '未完成' if classroomwork.try(:closed?)
    status.nil? ? '待做' : status
  end

  def has_score?
    self.score && !self.score.empty?
  end

  def is_finished?
    status == '已完成'
  end

  def auto_finish?
    student_classroomworks_exercises.select('check_desc').all?{|s| s.check_desc =~ /right/}
  end

  def canvas_exercises
    exercises.select{|e| e.is_need_canvas?}.uniq
  end

  def canvass
    canvas_exercises.map{|e| StudentClassroomworksExercises.where(exercise_id: e.id, student_classromwork_id: self.id).last}.flatten.map(&:canvas)
  end

  def score_num
    has_score? ? score : '暂无打分'
  end

  def all_right?
    times == 2
  end

  def set_first_check
    update_attribute(:first_update, updated_at) if status == '未批阅'
  end

  def need_modify
    update_attributes(status: '待改错', times: 1)
  end

  def complete
    update_attributes(status: '已完成', times: 2)
  end

  def first_submit?
    classroomwork.student_classroomworks[0] == self && student_classroomworks_exercises.all?{|e| e.created_at == e.updated_at}
  end
end
