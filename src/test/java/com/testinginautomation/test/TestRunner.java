package com.testinginautomation.test;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

public class TestRunner {

    @Test
    public Karate runTest() {
        return Karate.run("booking").relativeTo(getClass());
    }


}
