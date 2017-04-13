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
    assert_styles(
      '.anim',
      [{'left':'100px'},
       {'left':'100px'},
       {'left':'0px'},
       {'left':'0px'}]);
  }, "Autogenerated");

//pause
  at(1 * 1000, function() {
    assert_styles(
      '.anim',
      [{'left':'138.46153259277344px'},
       {'left':'140px'},
       {'left':'0px'},
       {'left':'0px'}]);
  }, "Autogenerated");
  at(2 * 1000, function() {
    assert_styles(
      '.anim',
      [{'left':'138.46153259277344px'},
       {'left':'140px'},
       {'left':'0px'},
       {'left':'0px'}]);
  }, "Autogenerated");
//unpause
  at(3 * 1000, function() {
    assert_styles(
      '.anim',
      [{'left':'176.92308044433594px'},
       {'left':'180px'},
       {'left':'0px'},
       {'left':'0px'}]);
  }, "Autogenerated");
//pause
  at(4 * 1000, function() {
    assert_styles(
      '.anim',
      [{'left':'200px'},
       {'left':'200px'},
       {'left':'116px'},
       {'left':'117.39130401611328px'}]);
  }, "Autogenerated");
  at(5 * 1000, function() {
    assert_styles(
      '.anim',
      [{'left':'200px'},
       {'left':'200px'},
       {'left':'116px'},
       {'left':'117.39130401611328px'}]);
  }, "Autogenerated");
//unpause
  at(6 * 1000, function() {
    assert_styles(
      '.anim',
      [{'left':'200px'},
       {'left':'200px'},
       {'left':'156px'},
       {'left':'160.86956787109375px'}]);
  }, "Autogenerated");
  at(7 * 1000, function() {
    assert_styles(
      '.anim',
      [{'left':'200px'},
       {'left':'200px'},
       {'left':'196px'},
       {'left':'200px'}]);
  }, "Autogenerated");
  at(7.1 * 1000, function() {
    assert_styles(
      '.anim',
      [{'left':'200px'},
       {'left':'200px'},
       {'left':'200px'},
       {'left':'200px'}]);
  }, "Autogenerated");
}, "Autogenerated checks.");