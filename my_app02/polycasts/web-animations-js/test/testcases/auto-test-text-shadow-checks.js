/**
 * Copyright 2017 Google Inc.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

timing_test(function() {
  at(0 * 1000, function() {
    assert_styles('body', {'textShadow':'rgb(255, 0, 0) 100px 100px 0px, rgb(255, 0, 0) 0px 100px 20px'});
  }, "Autogenerated");
  at(0.5 * 1000, function() {
    assert_styles('body', {'textShadow':'rgba(255, 0, 0, 0.74902) 75px 75px 0px, rgba(255, 0, 0, 0.74902) 0px 75px 15px'});
  }, "Autogenerated");
  at(1 * 1000, function() {
    assert_styles('body', {'textShadow':'rgba(255, 0, 0, 0.498039) 50px 50px 0px, rgba(255, 0, 0, 0.498039) 0px 50px 10px'});
  }, "Autogenerated");
  at(1.5 * 1000, function() {
    assert_styles('body', {'textShadow':'rgba(255, 0, 0, 0.247059) 25px 25px 0px, rgba(255, 0, 0, 0.247059) 0px 25px 5px'});
  }, "Autogenerated");
  at(2 * 1000, function() {
    assert_styles('body', {'textShadow':'rgb(0, 0, 0) 0px 0px 0px'});
  }, "Autogenerated");
  at(2.5 * 1000, function() {
    assert_styles('body', {'textShadow':'rgb(0, 0, 0) 0px 0px 0px'});
  }, "Autogenerated");
}, "Autogenerated checks.");