# Insite

Insite is a platform designed for educational influencers to share high-quality, long-form videos on various topics including knitting, gardening, coding, cooking, and more. Content creators can choose to offer their videos for free or set a price. Users can create accounts to find and follow content creators, watch videos, and bookmark their favorites.

## Features

-   **Landing Page:** Displays popular, trending, and recently added videos.
    
-   **Search & Filter:** Search for videos and filter results based on criteria.
    
-   **Video Show Page:** View individual videos and details.
    
-   **Profile Pages:** For both users and creators to update their details and view their followed creators and bookmarked videos.
    
-   **Signup/Login:** Secure authentication and account management.
    

## Tech Stack

-   **Backend:** Ruby on Rails
    
-   **Frontend:** Stimulus.js, HTML, SCSS
    
-   **Database:** PostgreSQL
    
-   **Authentication:** Devise gem
    
-   **Search:** pg_search gem
    
-   **Pagination:** Pagy gem
    

## Getting Started

### Prerequisites

-   Ruby version 3.1.2
    
-   Rails version 7.1.3
    
-   PostgreSQL
    

### Installation

1.  Clone the repository:

	    git clone  <repository-url>
    
	    cd insite

2.  Install dependencies:

	    bundle install

3.  Setup the database:

	    rails db:create
	    
	    rails db:migrate
	    
	    rails db:seed

4.  Start the server:

	    rails server

Visit http://localhost:3000 in your browser to see the application.

## Deployment

For deployment, you can use platforms like Heroku, AWS, or any other that supports Rails applications. Ensure that your environment variables and PostgreSQL database are configured properly.

## Contributing

We welcome contributions! Please open an issue or submit a pull request if you have suggestions or improvements.

## Acknowledgements

-   [Rails](https://rubyonrails.org/)
    
-   [Stimulus.js](https://stimulus.hotwired.dev/)
    
-   [Devise](https://github.com/heartcombo/devise)
    
-   [pg_search](https://github.com/Casecommons/pg_search)
    
-   [Pagy](https://github.com/ddnexus/pagy)
