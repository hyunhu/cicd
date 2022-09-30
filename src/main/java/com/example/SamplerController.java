package com.example;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SamplerController {

    @GetMapping("/sample")
    public String index() {
        return "Index Page";
    }
}
