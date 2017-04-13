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
    assert_styles("#target",{'left':'0px','backgroundColor':'rgb(176, 196, 222)'});
  });
  at(0.5 * 1000, function() {
    assert_styles("#target",{'left':'50px','backgroundColor':'rgb(176, 196, 222)'});
  });
  at(1.5 * 1000, function() {
    assert_styles("#target",{'left':'100px','backgroundColor':'rgb(176, 196, 222)'});
  });
  at(2 * 1000, function() {
    assert_styles("#target",{'left':'50px','backgroundColor':'rgb(176, 196, 222)'});
  });
  at(3 * 1000, function() {
    assert_styles("#target",{'left':'100px','backgroundColor':'rgb(0, 128, 0)'});
  });
}, "Auto generated tests");