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
  at( 0.0, function() {assert_styles('#a', {'left':'0px'})}, "Autogenerated test at t= 0.0");
  at( 1.0, function() {assert_styles('#a', {'left':'50px'})}, "Autogenerated test at t= 1.0");
  at( 2.0, function() {assert_styles('#a', {'left':'100px'})}, "Autogenerated test at t= 2.0");
  at( 3.0, function() {assert_styles('#a', {'left':'150px'})}, "Autogenerated test at t= 3.0");
  at( 4.0, function() {assert_styles('#a', {'left':'200px'})}, "Autogenerated test at t= 4.0");
  at( 5.0, function() {assert_styles('#a', {'left':'250px'})}, "Autogenerated test at t= 5.0");
  at( 6.0, function() {assert_styles('#a', {'left':'300px'})}, "Autogenerated test at t= 6.0");
  at( 7.0, function() {assert_styles('#a', {'left':'350px'})}, "Autogenerated test at t= 7.0");
  at( 8.0, function() {assert_styles('#a', {'left':'400px'})}, "Autogenerated test at t= 8.0");
  at( 9.0, function() {assert_styles('#a', {'left':'450px'})}, "Autogenerated test at t= 9.0");
  at(10.0 * 1000, function() {assert_styles('#a', {'left':'500px'})}, "Autogenerated");
  at(11.0 * 1000, function() {assert_styles('#a', {'left':'450px'})}, "Autogenerated");
  at(12.0 * 1000, function() {assert_styles('#a', {'left':'400px'})}, "Autogenerated");
  at(13.0 * 1000, function() {assert_styles('#a', {'left':'350px'})}, "Autogenerated");
  at(14.0 * 1000, function() {assert_styles('#a', {'left':'300px'})}, "Autogenerated");
  at(15.0 * 1000, function() {assert_styles('#a', {'left':'250px'})}, "Autogenerated");
  at(16.0 * 1000, function() {assert_styles('#a', {'left':'200px'})}, "Autogenerated");
  at(17.0 * 1000, function() {assert_styles('#a', {'left':'150px'})}, "Autogenerated");
  at(18.0 * 1000, function() {assert_styles('#a', {'left':'100px'})}, "Autogenerated");
  at(19.0 * 1000, function() {assert_styles('#a', {'left':'50px'})}, "Autogenerated");
  at(20.0 * 1000, function() {assert_styles('#a', {'left':'0px'})}, "Autogenerated");
}, "Autogenerated checks.");
