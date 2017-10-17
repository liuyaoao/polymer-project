const user_login = {
  userRoles: [],
  userId: '',
  userToken: '',
  userSelectedRoleName: '',
  defaultCategoryName: ''
};

const userLoginHandlers = {
	default(state) {
  	return state;
	},

	SET_USER_INFO (state, action) {
		var userId = action.userId;
		var userToken =action.userToken;
		return updateObject(state,{userId: userId, userToken: userToken});
	},

	GET_USER_ROLES (state, action) {
    return Object.assign({}, state, {
      userRoles: action.userRoles
    });
	},

	SET_USER_SELECTED_ROLE (state, action) {
    return Object.assign({}, state, {
      userSelectedRoleName: action.userSelectedRoleName
    });
	},

	SET_DEFAULTCATEGORYNAME (state, action) {
    return Object.assign({}, state, {
      defaultCategoryName: action.defaultCategoryName
    });
	},
};

const userReducer = createReducer(user_login, userLoginHandlers);
