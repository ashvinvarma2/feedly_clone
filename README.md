# README

### Description
  - This application is build with an intension of exploring new features of Rails 7 such as Hotwire ( Turbo + Stimulus )
  - Feedly helps you keep up with the topics and trends that matter most to you, without the overwhelm. We’ll show you how to get started.

### Prerequisites

* Ruby version - 3.2.2

* Database used - Postgresql

* Yarn
  
## Installation
  Follow the instructions given below:

1. Clone the repo
   * Using https
    ```sh
    git clone https://github.com/railsfactory-ashwin/feedly_clone.git
    ```
    * Using ssh
    ```sh
    git clone git@github.com:railsfactory-ashwin/feedly_clone.git
    ```
    
2. Navigate to the project directory
   ```sh
   cd FeedlyClone
   ```

3. Install dependencies
   ```sh
   bundle install
   ```

4. Set up the database
   ```sh
   rails db:create
   rails db:migrate
   rails db:seed
   ```

5. Install YARN
   ```sh
   brew install yarn
   ```

6. Install YARN packages
   ```sh
   yarn
   ```

7. Run the Rails Server
   ```sh
   bin/dev
   ```
   #### Note:
   If you want to debug the applicaiton than run the server using following command:
   ```sh
   rails s
   ```

   Also, run this following commands in separate tabs in your terminal.
   ```sh
   yarn build —watch
   yarn watch:css
   ```

<!-- CONTACT -->
## Contact

Your Name - Ashwin Varma - ashvinvarma2@gmail.com

Project Link: https://github.com/railsfactory-ashwin/feedly_clone

## Thank You

Thank you for checking out FeedlyClone! We appreciate your interest and hope you find our project useful. If you have any questions, suggestions, or contributions, feel free to reach out.

Special thanks to our contributors who have helped improve and grow this project:

- Magesh [magesh@sedintechnologies.com)

We appreciate your support!
