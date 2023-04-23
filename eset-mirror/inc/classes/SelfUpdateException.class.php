<?php

class SelfUpdateException extends Exception
{
    /**
     * SelfUpdateException constructor.
     */
    public function __construct()
    {
        $message = func_get_arg(0);
        $params = func_get_args();
        array_shift($params);
        parent::__construct(Language::t($message, $params));
    }

    /**
     * @return string
     */
    public function ErrorMessage()
    {
        return $this->getMessage();
    }
}