<?php

class Route
{
    private $_url = array();
    private $_method = array();
    /**
     *Builds a collection of internal URL's to look for
     * @param type $url 
     */
    public function add($url, $method = null)
    {
        $this->_url[] = '/'. trim($url, '/');
        if($method != null)
        {
            $this->_method[] = $method;
        }
    }
    public function submit()
    {
        
       $urlGetParam = isset($_GET['url'])? '/'. $_GET['url']: '/';
       
       foreach ($this->_url as $key => $value) 
               {
           /**
            * the below if statement will loop through the value submitted
            * to see if any of them matches the pages available. so the idea
            * is to create POST page, Get page etc
            */
                
                if(preg_match("#^$value$#", $urlGetParam))
                {
                    //$useMethod = $this->_method[$key];
                    // new $useMethod();
                    call_user_func($this->_method[$key]);
                    }
               }
           
       }
        
    
}
