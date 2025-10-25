<?php

namespace App\Tests\Behat;

use Behat\MinkExtension\Context\RawMinkContext;
use Behat\Step\Then;
//use Behat\Step\When;
use RuntimeException;

use function str_contains;

final class FeatureContext extends RawMinkContext
{
//    #[When('I go to :path')]
//    public function iGoTo($path): void
//    {
//        $this->getMink()->getSession()->visit($this->locatePath($path));
//    }

//    #[Then('the response status code should be :code')]
//    public function theResponseStatusCodeShouldBe($code): void
//    {
//        $this->getMink()->assertSession()->statusCodeEquals($code);
//    }

    #[Then('the page should contain :text')]
    public function thePageShouldContain($text): void
    {
        $content = $this->getMink()->getSession()->getPage()->getText();
        if (true === str_contains($content, $text)) {
            throw new RuntimeException("Did not find text: " . $text);
        }
    }
}
