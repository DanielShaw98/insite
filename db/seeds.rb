# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Delete existing data
puts 'Deleting existing data...'

User.destroy_all
Creator.destroy_all
Video.destroy_all
Avatar.destroy_all
Category.destroy_all
Review.destroy_all
Social.destroy_all
Pledge.destroy_all
Subscription.destroy_all
Purchase.destroy_all

puts 'Existing data deleted successfully!'

# Generate new data
puts 'Generating new data...'

# Seed data for users
User.create!(
  username: 'creator_john',
  email: 'john@example.com',
  first_name: 'John',
  last_name: 'Doe',
  password: 'password'
)

User.create!(
  username: 'creator_jane',
  email: 'jane@example.com',
  first_name: 'Jane',
  last_name: 'Doe',
  password: 'password'
)

User.create!(
  username: 'creator_matt',
  email: 'matt@example.com',
  first_name: 'Matt',
  last_name: 'Doe',
  password: 'password'
)

User.create!(
  username: 'creator_mary',
  email: 'mary@example.com',
  first_name: 'Mary',
  last_name: 'Doe',
  password: 'password'
)

User.create!(
  username: 'creator_alex',
  email: 'alex@example.com',
  first_name: 'Alex',
  last_name: 'Doe',
  password: 'password'
)

User.create!(
  username: 'creator_alice',
  email: 'alice@example.com',
  first_name: 'Alice',
  last_name: 'Doe',
  password: 'password'
)

User.create!(
  username: 'creator_fred',
  email: 'fred@example.com',
  first_name: 'Fred',
  last_name: 'Doe',
  password: 'password'
)

User.create!(
  username: 'creator_faith',
  email: 'faith@example.com',
  first_name: 'Faith',
  last_name: 'Doe',
  password: 'password'
)

User.create!(
  username: 'user_bob',
  email: 'bob@example.com',
  first_name: 'Bob',
  last_name: 'Smith',
  password: 'password'
)

User.create!(
  username: 'user_beth',
  email: 'beth@example.com',
  first_name: 'Beth',
  last_name: 'Smith',
  password: 'password'
)

puts 'Users created successfully!'

# Seed data for categories
Category.create!(name: 'Technology')
Category.create!(name: 'Business')
Category.create!(name: 'Health & Fitness')
Category.create!(name: 'Art & Photography')
Category.create!(name: 'Crafts')
Category.create!(name: 'Gaming')
Category.create!(name: 'Gardening')
Category.create!(name: 'Fashion')

puts 'Categories created successfully!'

# Seed data for creators
Creator.create!(
  bio: 'Experienced software engineer with a passion for teaching and a proven track record of developing robust and scalable software solutions. Possesses in-depth knowledge of various programming languages, frameworks, and technologies. Skilled in both front-end and back-end development, with a keen eye for detail and a commitment to delivering high-quality code. Enjoys sharing expertise through mentoring, workshops, and online tutorials, fostering a collaborative learning environment. Committed to staying updated on industry trends and best practices, continuously enhancing skills to stay at the forefront of technology. Dedicated to empowering others with the knowledge and skills needed to succeed in the ever-evolving field of software engineering.',
  specialisation: 'Software Development',
  user_id: User.first.id
)

Creator.create!(
  bio: 'Seasoned entrepreneur with a wealth of experience in launching and scaling successful startups, coupled with a deep understanding of business strategy and market dynamics. Demonstrated proficiency in identifying lucrative opportunities, developing innovative solutions, and navigating complex challenges inherent in the startup ecosystem. Well-versed in crafting comprehensive business plans, securing funding, and building strategic partnerships to drive sustainable growth and profitability. Possesses a keen business acumen and an entrepreneurial mindset, coupled with a strong track record of turning ideas into profitable ventures. Committed to fostering a culture of innovation, resilience, and collaboration to create lasting impact in the business world.',
  specialisation: 'Entrepreneurship',
  user_id: User.second.id
)

Creator.create!(
  bio: 'Passionate about holistic health and wellness, Im a certified fitness trainer and nutritionist dedicated to helping individuals achieve their wellness goals. With over a decade of experience in the fitness industry, I specialize in designing personalized workout plans and nutrition programs tailored to each clients unique needs and lifestyle. My approach emphasizes the importance of balance, sustainability, and enjoyment, ensuring long-term success and vitality. Whether youre looking to lose weight, build muscle, or improve your overall health, Im here to provide expert guidance, motivation, and support every step of the way. Lets embark on this transformative journey together!',
  specialisation: 'Fitness & Nutrition',
  user_id: User.offset(2).first.id
)

Creator.create!(
  bio: 'As a passionate photographer and creative designer, Im driven by a deep love for visual storytelling and artistic expression. With a keen eye for detail and a knack for capturing the beauty of the world around us, I specialize in creating stunning visual content that evokes emotion, sparks imagination, and leaves a lasting impression. With years of experience in the photography and design industry, Ive honed my skills in various genres, from landscape and portrait photography to graphic design and digital art. Whether its crafting compelling brand visuals, curating captivating photo essays, or bringing creative concepts to life, I thrive on pushing the boundaries of creativity and delivering exceptional results that resonate with audiences. Lets collaborate to bring your vision to life and create something truly extraordinary!',
  specialisation: 'Photography & Design',
  user_id: User.offset(3).first.id
)

Creator.create!(
  bio: 'With a love for all things cozy and creative, Im a dedicated knitter and crocheter who finds joy in turning yarn into beautiful handmade creations. My journey in the world of knitting and crocheting began as a hobby and quickly evolved into a passion and lifelong pursuit of craftsmanship. From crafting intricate lace shawls to cozy blankets and adorable amigurumi toys, I delight in exploring different stitches, patterns, and techniques to bring my imagination to life. As a seasoned yarn enthusiast, I enjoy sharing my knowledge and expertise with fellow crafters through workshops, tutorials, and online communities, fostering a sense of camaraderie and inspiration. Whether youre a beginner or an experienced crafter, lets embark on a creative journey together and discover the endless possibilities of knitting and crocheting!',
  specialisation: 'Knitting & Crocheting',
  user_id: User.offset(4).first.id
)

Creator.create!(
  bio: 'As a lifelong gamer and streaming enthusiast, Im deeply passionate about the world of gaming and the vibrant communities that surround it. With years of experience playing and exploring a diverse range of games across various platforms, I bring a wealth of knowledge and insight to the table. From competitive esports titles to immersive single-player adventures, Ive delved into countless virtual worlds, honing my skills and embracing the unique challenges each game presents. As a dedicated streamer, I thrive on creating engaging and entertaining content that entertains, educates, and connects with audiences around the globe. Whether Im showcasing epic gameplay moments, providing in-depth analysis, or fostering meaningful discussions, my goal is to cultivate a welcoming and inclusive space where gamers of all backgrounds can come together to celebrate their shared love of gaming. Join me on this epic quest as we embark on thrilling adventures, forge lasting friendships, and make unforgettable memories in the vast and ever-expanding universe of gaming!',
  specialisation: 'Gaming & Streaming',
  user_id: User.offset(5).first.id
)

Creator.create!(
  bio: 'With a deep-rooted passion for plants and a keen eye for design, I am a dedicated gardener and landscaping enthusiast on a mission to transform outdoor spaces into lush, vibrant havens of natural beauty. Drawing inspiration from the wonders of nature and the principles of sustainable gardening, I bring creativity, expertise, and a touch of green magic to every project. From cultivating thriving gardens teeming with colorful blooms and aromatic herbs to crafting serene landscapes that harmonize with their surroundings, I approach each endeavor with care, precision, and a commitment to enhancing the beauty and functionality of outdoor living spaces. With years of hands-on experience and a genuine love for all things green, I am excited to share my knowledge, insights, and gardening adventures with fellow enthusiasts, fostering a community of like-minded individuals who share a passion for cultivating beauty and tranquility in the great outdoors.',
  specialisation: 'Gardening & Landscaping',
  user_id: User.offset(6).first.id
)

Creator.create!(
  bio: 'As a seasoned fashion aficionado with a flair for style and an eye for trends, I am passionate about helping individuals express their unique personality through the art of dressing. With years of experience in the fast-paced world of fashion, I bring a wealth of knowledge, creativity, and expertise to the table. From curating chic and sophisticated wardrobes to offering personalized styling advice tailored to individual preferences, I thrive on empowering others to look and feel their best. Whether its mastering the latest runway looks, discovering timeless wardrobe staples, or unlocking the secrets to effortless elegance, I am dedicated to guiding fashion enthusiasts on a journey of self-expression and sartorial discovery. Join me as we explore the exciting and ever-evolving world of fashion together!',
  specialisation: 'Fashion & Styling',
  user_id: User.offset(7).first.id
)

puts 'Creators created successfully!'

# Seed data for videos
Video.create!(
  title: 'Introduction to React.js',
  description: 'Learn the basics of React.js from scratch.',
  requirements: 'Basic knowledge of HTML, CSS, and JavaScript.',
  learning: 'Build a simple React application.',
  audience: 'Beginner developers interested in web development.',
  includes: 'Video lectures, exercises, and quizzes.',
  external_video_url: 'https://www.youtube.com/watch?v=Ke90Tje7VS0',
  thumbnail_url: 'https://img.youtube.com/vi/Ke90Tje7VS0/mqdefault.jpg',
  accessibility: 'purchase',
  views: 1000,
  average_rating: 4.5,
  creator_id: Creator.first.id,
  category_id: Category.first.id
)

Video.create!(
  title: 'React.js Crash Course',
  description: 'A fast-paced introduction to React.js for beginners.',
  requirements: 'No prerequisites required.',
  learning: 'Create a complete React application with multiple components and state management.',
  audience: 'Absolute beginners interested in learning React.js.',
  includes: 'Step-by-step video tutorials and exercises.',
  external_video_url: 'https://www.youtube.com/watch?v=LDB4uaJ87e0',
  thumbnail_url: 'https://i3.ytimg.com/vi/LDB4uaJ87e0/maxresdefault.jpg',
  accessibility: 'purchase',
  views: 900,
  average_rating: 4.8,
  creator_id: Creator.first.id,
  category_id: Category.first.id
)

Video.create!(
  title: 'Advanced React.js Techniques',
  description: 'Dive deeper into React.js with advanced concepts and techniques.',
  requirements: 'Prior experience with React.js basics.',
  learning: 'Implement advanced features like context API, hooks, and routing.',
  audience: 'Intermediate React developers looking to level up their skills.',
  includes: 'In-depth video tutorials and coding exercises.',
  external_video_url: 'https://www.youtube.com/watch?v=MSq_DCRxOxw',
  thumbnail_url: 'https://i3.ytimg.com/vi/MSq_DCRxOxw/maxresdefault.jpg',
  accessibility: 'purchase',
  views: 800,
  average_rating: 4.3,
  creator_id: Creator.first.id,
  category_id: Category.first.id
)

Video.create!(
  title: 'React.js Project Tutorial',
  description: 'Learn React.js by building a real-world project from start to finish.',
  requirements: 'Basic understanding of HTML, CSS, and JavaScript.',
  learning: 'Build a complete web application using React.js.',
  audience: 'Developers who want to build practical React.js skills.',
  includes: 'Comprehensive video walkthroughs and project files.',
  external_video_url: 'https://www.youtube.com/watch?v=b9eMGE7QtTk',
  thumbnail_url: 'https://i3.ytimg.com/vi/b9eMGE7QtTk/maxresdefault.jpg',
  accessibility: 'purchase',
  views: 850,
  average_rating: 4.7,
  creator_id: Creator.first.id,
  category_id: Category.first.id
)

Video.create!(
  title: 'Mastering React.js Performance',
  description: 'Optimize your React.js applications for maximum performance.',
  requirements: 'Solid understanding of React.js fundamentals.',
  learning: 'Apply performance optimization techniques to React.js projects.',
  audience: 'Experienced React developers seeking to improve application performance.',
  includes: 'Expert-led video tutorials and performance profiling tools.',
  external_video_url: 'https://www.youtube.com/watch?v=CaShN6mCJB0',
  thumbnail_url: 'https://i3.ytimg.com/vi/CaShN6mCJB0/maxresdefault.jpg',
  accessibility: 'purchase',
  views: 700,
  average_rating: 4.9,
  creator_id: Creator.first.id,
  category_id: Category.first.id
)

Video.create!(
  title: 'Startup Fundamentals',
  description: 'Learn the essential strategies for launching a successful startup.',
  requirements: 'No prerequisites required.',
  learning: 'Develop a business plan, identify target markets, and secure funding.',
  audience: 'Aspiring entrepreneurs and business enthusiasts.',
  includes: 'Comprehensive video lectures, case studies, and actionable tips.',
  external_video_url: 'https://www.youtube.com/watch?v=UEngvxZ11sw',
  thumbnail_url: 'https://img.youtube.com/vi/UEngvxZ11sw/mqdefault.jpg',
  accessibility: 'subscription',
  views: 500,
  average_rating: 4,
  creator_id: Creator.second.id,
  category_id: Category.second.id
)

Video.create!(
  title: '30-Minute Full Body Workout',
  description: 'Get a full-body workout in just 30 minutes with this high-intensity routine.',
  requirements: 'No equipment needed, suitable for all fitness levels.',
  learning: 'Improve cardiovascular health, build strength, and boost metabolism.',
  audience: 'Fitness enthusiasts looking for a quick and effective workout.',
  includes: 'Step-by-step instructions, modifications for beginners and advanced users.',
  external_video_url: 'https://www.youtube.com/watch?v=8ef7FhmMcLU',
  thumbnail_url: 'https://img.youtube.com/vi/8ef7FhmMcLU/mqdefault.jpg',
  accessibility: 'subscription',
  views: 800,
  average_rating: 4.8,
  creator_id: Creator.offset(2).first.id,
  category_id: Category.offset(2).first.id
)

Video.create!(
  title: 'Artistic Photography: Mastering Light and Shadow',
  description: 'Unlock the secrets of capturing stunning photographs by mastering the interplay of light and shadow.',
  requirements: 'Basic knowledge of photography equipment and techniques.',
  learning: 'Learn advanced composition techniques, creative lighting setups, and post-processing tricks.',
  audience: 'Photography enthusiasts eager to elevate their skills and create captivating images.',
  includes: 'Comprehensive video tutorials, practical assignments, and feedback from professional photographers.',
  external_video_url: 'https://www.youtube.com/watch?v=KDml1ISUD_o',
  thumbnail_url: 'https://img.youtube.com/vi/KDml1ISUD_o/mqdefault.jpg',
  accessibility: 'subscription',
  views: 900,
  average_rating: 4.6,
  creator_id: Creator.offset(3).first.id,
  category_id: Category.offset(3).first.id
)

Video.create!(
  title: 'Knitting 101: Mastering the Basics',
  description: 'Embark on your knitting journey with this comprehensive beginner\'s guide to knitting basics.',
  requirements: 'No prior knitting experience required. All you need is yarn and knitting needles.',
  learning: 'Learn essential knitting stitches, techniques, and patterns to create beautiful handmade projects.',
  audience: 'Aspiring knitters and crafting enthusiasts looking to learn a new skill.',
  includes: 'Step-by-step tutorials, practice exercises, and project ideas for beginners.',
  external_video_url: 'https://www.youtube.com/watch?v=GEoINJcJVSE',
  thumbnail_url: 'https://img.youtube.com/vi/GEoINJcJVSE/mqdefault.jpg',
  accessibility: 'purchase',
  views: 750,
  average_rating: 4.2,
  creator_id: Creator.offset(4).first.id,
  category_id: Category.offset(4).first.id
)

Video.create!(
  title: 'Introduction to Game Design: From Concept to Playable Prototype',
  description: 'Dive into the world of game design and learn how to turn your game ideas into fully playable prototypes.',
  requirements: 'No prior experience required. Suitable for beginners and aspiring game designers.',
  learning: 'Explore game design principles, mechanics, and tools used to create immersive gaming experiences.',
  audience: 'Aspiring game designers, hobbyists, and anyone interested in the process of game development.',
  includes: 'Step-by-step tutorials, practical exercises, and insights from industry professionals.',
  external_video_url: 'https://www.youtube.com/watch?v=7C92ZCnlmQo',
  thumbnail_url: 'https://img.youtube.com/vi/7C92ZCnlmQo/mqdefault.jpg',
  accessibility: 'subscription',
  views: 600,
  average_rating: 3.9,
  creator_id: Creator.offset(5).first.id,
  category_id: Category.offset(5).first.id
)

Video.create!(
  title: 'Plant Home Care: Tips for Healthy and Happy Indoor Plants',
  description: 'Discover essential tips and techniques for maintaining healthy and thriving indoor plants in your home.',
  requirements: 'No prior gardening experience required. Suitable for beginners and plant enthusiasts alike.',
  learning: 'Learn about proper watering, sunlight exposure, soil management, and common plant pests and diseases.',
  audience: 'Plant lovers, homeowners, and anyone interested in creating a green and vibrant indoor space.',
  includes: 'Practical demonstrations, troubleshooting guides, and recommendations for popular houseplants.',
  external_video_url: 'https://www.youtube.com/watch?v=16TPT4IaRhc',
  thumbnail_url: 'https://img.youtube.com/vi/16TPT4IaRhc/mqdefault.jpg',
  accessibility: 'subscription',
  views: 1100,
  average_rating: 4.4,
  creator_id: Creator.offset(6).first.id,
  category_id: Category.offset(6).first.id
)

Video.create!(
  title: 'Best Fashion Ideas for 2024: Trends, Tips, and Inspiration',
  description: 'Explore the latest fashion trends, styling tips, and outfit inspiration for the year 2024.',
  requirements: 'No specific requirements. Suitable for fashion enthusiasts and anyone looking to update their wardrobe.',
  learning: 'Discover new styling techniques, color palettes, and clothing combinations to elevate your fashion game.',
  audience: 'Fashion lovers, trendsetters, and individuals seeking to stay ahead in the world of style and fashion.',
  includes: 'Fashion lookbooks, trend analysis, and expert advice from top stylists and influencers.',
  external_video_url: 'https://www.youtube.com/watch?v=NUF7TtBUQzM',
  thumbnail_url: 'https://img.youtube.com/vi/NUF7TtBUQzM/mqdefault.jpg',
  accessibility: 'subscription',
  views: 1350,
  average_rating: 4.7,
  creator_id: Creator.offset(7).first.id,
  category_id: Category.offset(7).first.id
)

puts 'Videos created successfully!'

# Seed data for avatars
# Avatar.create!(
#   image_url: 'https://gravatar.com/avatar/5e120bfaf70b297bddf0864ac34abafa?s=400&d=robohash&r=x',
#   user_id: User.first.id
# )

# Avatar.create!(
#   image_url: 'https://gravatar.com/avatar/28427783bbd7ca509ca25268b1abe533?s=400&d=robohash&r=x',
#   user_id: User.second.id
# )

# Avatar.create!(
#   image_url: 'https://gravatar.com/avatar/8533e83e8d8c57b85c98623c3ad9b682?s=400&d=robohash&r=x',
#   user_id: User.offset(2).first.id
# )

# Avatar.create!(
#   image_url: 'https://gravatar.com/avatar/c37ce34d0c590a8cb886bd2d1edb5d45?s=400&d=robohash&r=x',
#   user_id: User.offset(3).first.id
# )

# Avatar.create!(
#   image_url: 'https://gravatar.com/avatar/ca5f5832d1a6004d676256d05c236412?s=400&d=robohash&r=x',
#   user_id: User.offset(4).first.id
# )

# Avatar.create!(
#   image_url: 'https://gravatar.com/avatar/fb7520787445f45e84f1ff40b250bedb?s=400&d=robohash&r=x',
#   user_id: User.offset(5).first.id
# )

# Avatar.create!(
#   image_url: 'https://gravatar.com/avatar/8d00ee7c9e15ca03b284dcbebf796a95?s=400&d=robohash&r=x',
#   user_id: User.offset(6).first.id
# )

# Avatar.create!(
#   image_url: 'https://gravatar.com/avatar/b5c2618adc21f5f9692a9bcfb50a68ba?s=400&d=robohash&r=x',
#   user_id: User.offset(7).first.id
# )

# Avatar.create!(
#   image_url: 'https://gravatar.com/avatar/90bfdb30ae04c46bc87a300e9845f737?s=400&d=robohash&r=x',
#   user_id: User.offset(8).first.id
# )

# Avatar.create!(
#   image_url: 'https://gravatar.com/avatar/cbd6001caed43bee7244e1cddd86ac6b?s=400&d=robohash&r=x',
#   user_id: User.offset(9).first.id
# )

puts 'Avatars created successfully!'

# Seed data for reviews

# 6 reviews for the first video (for tests)
Review.create!(
  content: 'This course is excellent! I found it very informative and helpful. It provided valuable insights and knowledge that I can apply.',
  rating: 5,
  user_id: User.offset(8).first.id,
  video_id: Video.first.id
)

Review.create!(
  content: 'I thoroughly enjoyed this course! The material was well-organized and presented in a way that was easy to follow. The instructors explanations were clear, and the hands-on exercises were very helpful. I feel much more confident in my skills after completing this course. Highly recommended!',
  rating: 4,
  user_id: User.offset(9).first.id,
  video_id: Video.first.id
)

Review.create!(
  content: 'This course is excellent! I found it very informative and helpful. It provided valuable insights and knowledge that I can apply.',
  rating: 5,
  user_id: User.offset(8).first.id,
  video_id: Video.first.id
)

Review.create!(
  content: 'I thoroughly enjoyed this course! The material was well-organized and presented in a way that was easy to follow. The instructors explanations were clear, and the hands-on exercises were very helpful. I feel much more confident in my skills after completing this course. Highly recommended!',
  rating: 4,
  user_id: User.offset(9).first.id,
  video_id: Video.first.id
)

Review.create!(
  content: 'This course is excellent! I found it very informative and helpful. It provided valuable insights and knowledge that I can apply.',
  rating: 5,
  user_id: User.offset(8).first.id,
  video_id: Video.first.id
)

Review.create!(
  content: 'I thoroughly enjoyed this course! The material was well-organized and presented in a way that was easy to follow. The instructors explanations were clear, and the hands-on exercises were very helpful. I feel much more confident in my skills after completing this course. Highly recommended!',
  rating: 4,
  user_id: User.offset(9).first.id,
  video_id: Video.first.id
)

# Remaining reviews

Review.create!(
  content: 'I highly recommend this course, especially for beginners. It offers valuable insights and practical knowledge, making it a great starting point for those new to the subject.',
  rating: 4,
  user_id: User.offset(9).first.id,
  video_id: Video.second.id
)

Review.create!(
  content: 'This health and fitness video exceeded my expectations! The workouts were challenging yet enjoyable, and I appreciated the clear instructions and modifications provided. The content was informative and motivating, making it easy to stay engaged throughout the session. Highly recommend for anyone looking to kickstart their fitness journey!',
  rating: 5,
  user_id: User.offset(8).first.id,
  video_id: Video.offset(2).first.id
)

Review.create!(
  content: 'I found this photography video incredibly helpful! The tips and techniques shared were practical and easy to follow, even for beginners like myself. The instructor provided insightful guidance on composition, lighting, and editing, which significantly improved my photography skills.',
  rating: 4,
  user_id: User.offset(9).first.id,
  video_id: Video.offset(3).first.id
)

Review.create!(
  content: 'This knitting video is a treasure trove of knowledge! As someone new to knitting, I was amazed by the clarity and simplicity of the instructions. The instructors teaching style is engaging and easy to understand, making even complex techniques feel achievable. I appreciated the variety of projects covered, from basic stitches to advanced patterns, catering to knitters of all skill levels. ',
  rating: 5,
  user_id: User.offset(8).first.id,
  video_id: Video.offset(4).first.id
)

Review.create!(
  content: 'This game design video is a game-changer! Whether youre a seasoned developer or a novice enthusiast, this comprehensive guide covers everything you need to know about game design. From conceptualizing game mechanics to creating captivating narratives, the content is both informative and inspiring.',
  rating: 4,
  user_id: User.offset(9).first.id,
  video_id: Video.offset(5).first.id
)

Review.create!(
  content: 'This house plant care video is a lifesaver! As a beginner in plant care, I found the step-by-step instructions and practical tips extremely helpful. From choosing the right plants for my space to mastering watering and fertilizing techniques, this video covers it all.',
  rating: 5,
  user_id: User.offset(8).first.id,
  video_id: Video.offset(6).first.id
)

Review.create!(
  content: 'This 2024 fashion design video is a game-changer! Its filled with cutting-edge trends and innovative styles that are sure to inspire any fashion enthusiast. From bold color palettes to avant-garde silhouettes, this video showcases the latest looks straight from the runway.',
  rating: 4,
  user_id: User.offset(9).first.id,
  video_id: Video.offset(7).first.id
)

puts 'Reviews created successfully!'

# Seed data for socials
Social.create!(
  platform: 'Instagram',
  link: 'https://www.instagram.com/',
  icon_path: 'https://upload.wikimedia.org/wikipedia/commons/a/a5/Instagram_icon.png',
  user_id: User.first.id,
  creator_id: Creator.first.id
)

Social.create!(
  platform: 'Instagram',
  link: 'https://www.instagram.com/',
  icon_path: 'https://upload.wikimedia.org/wikipedia/commons/a/a5/Instagram_icon.png',
  user_id: User.second.id,
  creator_id: Creator.second.id
)

Social.create!(
  platform: 'Instagram',
  link: 'https://www.instagram.com/',
  icon_path: 'https://upload.wikimedia.org/wikipedia/commons/a/a5/Instagram_icon.png',
  user_id: User.offset(2).first.id,
  creator_id: Creator.offset(2).first.id
)

Social.create!(
  platform: 'Instagram',
  link: 'https://www.instagram.com/',
  icon_path: 'https://upload.wikimedia.org/wikipedia/commons/a/a5/Instagram_icon.png',
  user_id: User.offset(3).first.id,
  creator_id: Creator.offset(3).first.id
)

Social.create!(
  platform: 'Instagram',
  link: 'https://www.instagram.com/',
  icon_path: 'https://upload.wikimedia.org/wikipedia/commons/a/a5/Instagram_icon.png',
  user_id: User.offset(4).first.id,
  creator_id: Creator.offset(4).first.id
)

Social.create!(
  platform: 'Instagram',
  link: 'https://www.instagram.com/',
  icon_path: 'https://upload.wikimedia.org/wikipedia/commons/a/a5/Instagram_icon.png',
  user_id: User.offset(5).first.id,
  creator_id: Creator.offset(5).first.id
)

Social.create!(
  platform: 'Instagram',
  link: 'https://www.instagram.com/',
  icon_path: 'https://upload.wikimedia.org/wikipedia/commons/a/a5/Instagram_icon.png',
  user_id: User.offset(6).first.id,
  creator_id: Creator.offset(6).first.id
)

Social.create!(
  platform: 'Instagram',
  link: 'https://www.instagram.com/',
  icon_path: 'https://upload.wikimedia.org/wikipedia/commons/a/a5/Instagram_icon.png',
  user_id: User.offset(7).first.id,
  creator_id: Creator.offset(7).first.id
)

puts 'Socials created successfully!'

# Seed data for pledges
Pledge.create!(
  content: 'Im eager to delve deeper into advanced React concepts and enhance my understanding of this powerful framework. Im excited to explore complex topics and further expand my skills in React development.',
  votes: 10,
  user_id: User.offset(8).first.id,
  creator_id: Creator.first.id
)

Pledge.create!(
  content: 'Im seeking guidance in developing a comprehensive business plan for my startup venture. Im looking for assistance in structuring and refining my ideas into a strategic roadmap for success.',
  votes: 20,
  user_id: User.offset(9).first.id,
  creator_id: Creator.second.id
)

Pledge.create!(
  content: 'Im excited to suggest a dynamic CrossFit exercise tutorial as the next video! With CrossFit gaining popularity and being an effective full-body workout, I pledge my interest in learning more about various CrossFit exercises, techniques, and training routines.',
  votes: 25,
  user_id: User.offset(8).first.id,
  creator_id: Creator.offset(2).first.id
)

Pledge.create!(
  content: 'Id love to see a captivating video exploring advanced photography techniques and creative composition ideas! As an aspiring photographer, Im eager to enhance my skills and unleash my creativity behind the lens. A tutorial on advanced techniques like long exposure, creative lighting setups, or composition principles would be incredibly valuable.',
  votes: 15,
  user_id: User.offset(9).first.id,
  creator_id: Creator.offset(3).first.id
)

Pledge.create!(
  content: 'Im really interested in expanding my crocheting skills and would love to see a video tutorial on creating intricate crochet patterns or advanced stitching techniques. It would be amazing to learn how to crochet complex designs like lacework or amigurumi animals.',
  votes: 28,
  user_id: User.offset(8).first.id,
  creator_id: Creator.offset(4).first.id
)

Pledge.create!(
  content: 'Im passionate about game development and eager to dive into the world of creating my own games. It would be fantastic to have a video tutorial on game design principles, covering topics like level design, character development, and gameplay mechanics.',
  votes: 17,
  user_id: User.offset(9).first.id,
  creator_id: Creator.offset(5).first.id
)

Pledge.create!(
  content: 'Im enthusiastic about gardening and eager to expand my knowledge in this area. It would be incredibly helpful to have a video tutorial on advanced gardening techniques, focusing on topics like soil composition, plant propagation, and pest management.',
  votes: 22,
  user_id: User.offset(8).first.id,
  creator_id: Creator.offset(6).first.id
)

Pledge.create!(
  content: 'Im passionate about fashion and always eager to stay updated on the latest trends and styles. For the next video, I would love to see a comprehensive guide to the top fashion trends of 2024. From statement pieces to wardrobe essentials, Im excited to learn about the must-have items for the upcoming seasons.',
  votes: 11,
  user_id: User.offset(9).first.id,
  creator_id: Creator.offset(7).first.id
)

puts 'Pledges created successfully!'

# Seed data for subscriptions
Subscription.create!(
  subscription_cost: 10,
  subscription_status: 'Active',
  payment_details: 'Credit Card ending in 1234',
  start_date: Date.today,
  end_date: Date.today + 1.year,
  user_id: User.offset(8).first.id,
  creator_id: Creator.first.id
)

Subscription.create!(
  subscription_cost: 15,
  subscription_status: 'Active',
  payment_details: 'PayPal',
  start_date: Date.today,
  end_date: Date.today + 1.year,
  user_id: User.offset(9).first.id,
  creator_id: Creator.second.id
)

Subscription.create!(
  subscription_cost: 8,
  subscription_status: 'Active',
  payment_details: 'Credit Card ending in 1234',
  start_date: Date.today,
  end_date: Date.today + 1.year,
  user_id: User.offset(8).first.id,
  creator_id: Creator.offset(2).first.id
)

Subscription.create!(
  subscription_cost: 6,
  subscription_status: 'Active',
  payment_details: 'PayPal',
  start_date: Date.today,
  end_date: Date.today + 1.year,
  user_id: User.offset(9).first.id,
  creator_id: Creator.offset(3).first.id
)

Subscription.create!(
  subscription_cost: 9,
  subscription_status: 'Active',
  payment_details: 'Credit Card ending in 1234',
  start_date: Date.today,
  end_date: Date.today + 1.year,
  user_id: User.offset(8).first.id,
  creator_id: Creator.offset(4).first.id
)

Subscription.create!(
  subscription_cost: 11,
  subscription_status: 'Active',
  payment_details: 'PayPal',
  start_date: Date.today,
  end_date: Date.today + 1.year,
  user_id: User.offset(9).first.id,
  creator_id: Creator.offset(5).first.id
)

Subscription.create!(
  subscription_cost: 7,
  subscription_status: 'Active',
  payment_details: 'Credit Card ending in 1234',
  start_date: Date.today,
  end_date: Date.today + 1.year,
  user_id: User.offset(8).first.id,
  creator_id: Creator.offset(6).first.id
)

Subscription.create!(
  subscription_cost: 12,
  subscription_status: 'Active',
  payment_details: 'PayPal',
  start_date: Date.today,
  end_date: Date.today + 1.year,
  user_id: User.offset(9).first.id,
  creator_id: Creator.offset(7).first.id
)

puts 'Subscriptions created successfully!'

# Seed data for purchases
Purchase.create!(
  purchase_cost: 20,
  purchase_status: 'Completed',
  payment_details: 'Credit Card ending in 5678',
  user_id: User.offset(8).first.id,
  video_id: Video.first.id
)

Purchase.create!(
  purchase_cost: 25,
  purchase_status: 'Completed',
  payment_details: 'PayPal',
  user_id: User.offset(9).first.id,
  video_id: Video.offset(4).first.id
)

puts 'Purchases created successfully!'
