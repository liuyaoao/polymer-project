
function updateObject(oldObject, newValues) {
  // 用空对象作为第一个参数传递给 Object.assign，以确保是复制数据，而不是去改变原来的数据
  return Object.assign({}, oldObject, newValues);
}

function updateItemInArray(array, itemId, updateItemCallback) {
    const updatedItems = array.map(item => {
        if(item.id !== itemId) {
            // 因为我们只想更新一个项目，所以保留所有的其他项目
            return item;
        }

        // 使用提供的回调来创建新的项目
        const updatedItem = updateItemCallback(item);
        return updatedItem;
    });

    return updatedItems;
}


//减少样板代码-创建reducer
function createReducer(initialState, handlers) {
  return function reducer(state = initialState, action) {
    if (handlers.hasOwnProperty(action.type)) {
      return handlers[action.type](state, action);
    } else {
      return state;
    }
  }
}

//根据状态码错误,跳转到指定界面
function errorToLoginPage(status,page){
  if(status === 401) {
    this.goTo(page);
  }
}

function reqErrorToLoginPage(page){
  this.goTo(page);
}

function goTo(page){
  if(!page || page == 'login')
    page = "";
  window.history.pushState({}, null, Window.AppConfig.appRoute + '/'+page);
  window.dispatchEvent(new CustomEvent('location-changed'));
  return;
}

function uuidv4() {
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
    var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
    return v.toString(16);
  });
}
