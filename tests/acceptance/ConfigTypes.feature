Feature: Config helper
    The global config helper will return a strict type

    Background:
        Given I have the following config
"""
<?xml version="1.0"?>
<psalm errorLevel="1" findUnusedCode="false">
    <projectFiles>
        <directory name="."/>
        <ignoreFiles> <directory name="../../vendor"/> </ignoreFiles>
    </projectFiles>
    <plugins>
        <pluginClass class="Psalm\LaravelPlugin\Plugin"/>
    </plugins>
</psalm>
"""
        And I have the following code preamble
"""
<?php declare(strict_types=1);
"""

    Scenario: config with no arguments returns a repository instance
        Given I have the following code
  """
  function test(): \Illuminate\Config\Repository {
    return config();
  }
  """
        When I run Psalm
        Then I see no errors

    Scenario: config with one argument
        Given I have the following code
    """
    /**
    * @return mixed
    */
    function test()
    {
        return config('app.name');
    }
    """
        When I run Psalm
        Then I see no errors

    Scenario: config with first null argument and second argument provided
        Given I have the following code
    """
    /**
    * @return mixed
    */
    function test()
    {
        return config('app.non-existent', false);
    }
    """
        When I run Psalm
        Then I see no errors

    Scenario: config setting at runtime
        Given I have the following code
    """
    /**
    * @return null
    */
    function test()
    {
        return config(['app.non-existent' => false]);
    }
    """
        When I run Psalm
        Then I see no errors
