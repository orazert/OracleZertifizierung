<?php

class WarenkorbController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
    	return $this->_helper->redirector('cc1');
    }

    public function cc1Action()
    {
                $warenkorb = new Default_Model_Warenkorb();
                $this->view->entries = $warenkorb->fetchCc1();
                
    }
    
   public function wcAction()
    {
                $warenkorb = new Default_Model_Warenkorb();
                $this->view->entries = $warenkorb->fetchWc();
                
    }
    
       public function cc3Action()
    {
                $warenkorb = new Default_Model_Warenkorb();
                $this->view->entries = $warenkorb->fetchCc3();
                
    }
    
           public function cc2Action()
    {
                $warenkorb = new Default_Model_Warenkorb();
                $this->view->entries = $warenkorb->fetchCc2();
                
    }
    /*
     public function signAction()
    {
        $request = $this->getRequest();
        $form    = new Default_Form_Guestbook();

        if ($this->getRequest()->isPost()) {
            if ($form->isValid($request->getPost())) {
                $model = new Default_Model_Guestbook($form->getValues());
                $model->save();
                return $this->_helper->redirector('index');
            }
        }
        
        $this->view->form = $form;
    }

    public function loginAction()
    {
                //$guestbook = new Default_Model_Guestbook();
                //$this->view->entries = $guestbook->fetchAll();
                echo "xxxxxxxxxxxxxxxxx<br>";

    }*/

}



