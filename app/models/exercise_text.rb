class ExerciseText < ActiveRecord::Base
  attr_accessible :book_id, :title, :content, :page, :section_id, :photo
  has_attached_file :photo
  belongs_to :book
  belongs_to :section
  has_many :exercises
  before_save :clean_content

  def clean_content
    transformer = lambda do |env|
      node = env[:node]
      node_name = env[:node_name]
      return if %w[o:p font pre style script meta].include? node_name

      return if (node_name == "p" || node_name == "span" ) and node.content.empty? && node.children.empty?

      style = node.attribute("style")
      if !style.nil?
        styles = style.value.split(";")
        styles.reject! do |s|
          name,value = s.split(":")
          !%w[color background font-style font-weight text-decoration text-align].include?(name)
        end
        style.value=styles.join(";")
        node.remove_attribute(style.name)
      end

      {:node_whitelist => [node]}
    end

    self.content = Sanitize.clean(self.content, :remove_contents => true, :transformer => transformer)
  end
  e
end
