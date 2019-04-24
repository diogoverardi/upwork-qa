# upwork-qa

<h2>Automated Testing Upwork Interview Task. </h2>

Created by <b>Diogo Verardi</b> 

***********************************************************************************************
__Gems used:__

- [Selenium WebDriver](https://docs.seleniumhq.org/download/)

***********************************************************************************************

__Steps:__

1 - Clone this repository via command line
- `$ git clone https://github.com/diogoverardi/upwork-qa.git`

2 - Go to the directory in which you have cloned the repository 
- `$ cd {path}/upwork-qa/`

3 - Install Selenium Gem
- `$ bundle install`

4 - Run the TestCase: 
- `$ ruby test_cases/find_freelancers.rb`
 
4.1 - change the Browser and/or keyword by terminal arguments
- `$ ruby test_cases/find_freelancers.rb "{Browser}" "{Keyword}"`
- `$ ruby test_cases/find_freelancers.rb "chrome" "magento"`
- `$ ruby test_cases/find_freelancers.rb "firefox" "ruby"`

4.2 - Or you can change by modifying the following file (this way you can just run #4 without giving any arguments)
- `$ nano resources/config/find_freelancers.rb`