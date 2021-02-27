function(){
  
	tabPanel("About",
		HTML("<h1> Ahmad Nazzal </h1>
        <p>
        
        The end result of this project will be to showcase the COVID 19 data and set up a vaccination strategy that will
        streamline the recovery process in Canada. This data is simulated and does not take in any real life data, but the values can be maniuplated
        to resemble the real life value of 80% probability the vaccine works. 
   
        </p>
        
      	<p>  
      	
	      I am a Graduate Student at Carleton University, and I'm almost done with my first year. 
        Before moving to Canada, I lived in California (Bay Area) and did my Bachelors in Applied Mathematics
		    at San Francisco State University. My passion for Statistics/Data Analysis was sparked by a book I read,
		    The Power of Habit by Charles Duhigg. 
		     
		    </p>"),#end of html part 1.
		
		
        #Notice that I used double quotes (") above because otherwise it would interfere with
        # the single quote in the word (don't)
        HTML('
        <div style="clear: left;">
        </div>
        
        <p>
        <a href="https://www.linkedin.com/in/ahmadnazzal/" target="_blank">LinkedIn</a>
        </p>
        
         <p>
        <a href="https://github.com/anazzal21/STAT-5702-Project" target="_blank">MyGithub</a>
        </p>
        
        '),#End of html part 2
		value="about"
       
        
	)
  
  

  
  
}
