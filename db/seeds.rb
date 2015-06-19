require 'faker'
require 'factory_girl'
####production seeds

kyle = User.create(handle: "kylesnowschwartz", email: "kyle.snowschwartz@gmail.com", password: "password")
kelly = User.create(handle: "kel", email: "kellymdev@gmail.com", password: "password")
t = User.create(handle: "silvertaniwha", email: "teaihebutler@gmail.com", password: "password")

tsposts = [
  Post.create(img_url: "https://trello-attachments.s3.amazonaws.com/558399d319ef3af5453c4b63/289x119/03f77d3b6234b6e54bb4ba6c54c8dd87/typeface.png"),
  Post.create(img_url: "https://trello-attachments.s3.amazonaws.com/558399d319ef3af5453c4b63/1236x660/6f1baa4c2a5d3fe79dc92ca549dc3b42/trello.png"),
Post.create(img_url: "https://trello-attachments.s3.amazonaws.com/558399d319ef3af5453c4b63/754x331/4184764ef269b22e130a968f3c5ea73d/schema.png"),
Post.create(img_url: "https://trello-attachments.s3.amazonaws.com/558399d319ef3af5453c4b63/3264x2448/8aa51321a334eb13bccfc922d54f9547/pencil.JPG"),
Post.create(img_url: "https://trello-attachments.s3.amazonaws.com/558399d319ef3af5453c4b63/724x1024/efb08da63b7ccd9c6d2c0225c4c360bb/model_tieke.jpg"),
Post.create(img_url: "https://trello-attachments.s3.amazonaws.com/558399d319ef3af5453c4b63/480x360/fb1725e4e8cb123f163f1a6507717715/fonz.jpg")
]

kellysposts = [
Post.create(img_url: "https://trello-attachments.s3.amazonaws.com/558399b8a0c9143065a28045/1750x1092/f8c2088a9b434bf17365cebc4d2d1c96/css.png"),
Post.create(img_url: "https://trello-attachments.s3.amazonaws.com/558399b8a0c9143065a28045/1366x1188/eedfe115a32b2c7725f16a4b6886202a/flickr.png"),
Post.create(img_url: "https://trello-attachments.s3.amazonaws.com/558399b8a0c9143065a28045/1308x724/016fb2c3e5f983b2de493227f70af18a/routes.png"),
Post.create(img_url: "https://trello-attachments.s3.amazonaws.com/558399b8a0c9143065a28045/1138x692/249f16f931690109179bdd337ab7c620/css_code.png"),
Post.create(img_url: "https://trello-attachments.s3.amazonaws.com/558399b8a0c9143065a28045/1210x378/29ab07b5a4df925e3487e7be59a9d901/navbar_code.png"),
Post.create(img_url: "https://trello-attachments.s3.amazonaws.com/558399b8a0c9143065a28045/1176x416/511666505a250865bd836c2c92c95528/colours.png")
]

kylesposts = [
Post.create(img_url: "https://trello-attachments.s3.amazonaws.com/55839c8723ef6fd0310c9630/523x397/5bbd1aaea66edd43f0cd44c54553c192/capybara.png"),
Post.create(img_url: "https://trello-attachments.s3.amazonaws.com/55839c8723ef6fd0310c9630/670x747/498cb2385bce0bd4ab608d081501aec2/nyan_cat.png"),
Post.create(img_url: "https://trello-attachments.s3.amazonaws.com/55839c8723ef6fd0310c9630/643x207/82d0b11959b693c97396cba6d84656a3/authenticate_rspec.png"),
Post.create(img_url: "https://trello-attachments.s3.amazonaws.com/55839c8723ef6fd0310c9630/830x527/44fbec284268056ea0edbd62937284b7/user_model.png"),
Post.create(img_url: "https://trello-attachments.s3.amazonaws.com/55839c8723ef6fd0310c9630/604x435/5f01125bc865fc2981394767cd30ba9c/Screen_Shot_2015-06-19_at_4.32.54_PM.png"),
Post.create(img_url: "https://trello-attachments.s3.amazonaws.com/55839c8723ef6fd0310c9630/731x503/cfbd4a3726b50089dded64f0b3d2ad39/mutter_to_yourself.png")
]

kylesposts.each {|post| kyle.posts << post}
kellysposts.each {|post| kelly.posts << post}
tsposts.each {|post| t.posts << post}




###development seeds
def development_seeds(integer)
  development_seeds_array = []

  integer.times {development_seeds_array << FactoryGirl.create(:user)}

  development_seeds_array.each do |user|
    random_num_of_followers(user, development_seeds_array)
    random_num_of_posts(user)
  end

end

private

  def sampled_follower_id_minus_user(user, set)
    users_minus_user = set - User.where(id: user.id)
    users_minus_user.sample.id
  end

  def random_num_of_followers(user, set)
    rand(3..20).times {user.followers << FactoryGirl.create(:follower, user_follower_id: sampled_follower_id_minus_user(user, set))}
  end

  def random_num_of_posts(user)
    rand(1..10).times {user.posts << FactoryGirl.create(:post)}
  end

  development_seeds(2)