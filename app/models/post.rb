class Post < ApplicationRecord
    belongs_to :user
    
    has_many :likes
    has_many :dislikes
    has_many :comments
    has_many :mypages
    has_many :liked_users, through: :likes, source: :user
    has_many :disliked_users, through: :dislikes, source: :user
    mount_uploader :image, PostImageUploader
    
    has_and_belongs_to_many :tags
    
    after_create do
        post = Post.find_by(id: self.id)
        hashtags = self.content.scan(/[#＃][a-z|A-Z|가-힣|0-9|\w]+/)
        hashtags.uniq.map do |hashtag|
            tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
            post.tags << tag
        end
    end
    
    before_update do
        post = Post.find_by(id: self.id)
        post.tags.clear
        hashtags = self.content.scan(/[#＃][a-z|A-Z|가-힣|0-9|\w]+/)
        hashtags.uniq.map do |hashtag|
            tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
            post.tags << tag
        end
    end
end
