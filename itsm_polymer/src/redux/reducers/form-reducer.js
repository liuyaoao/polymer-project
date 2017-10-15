const initial_form = {
  message: 'Hello from PolymerRedux'
};

const formHandlers = {
	default(state) {
  	return state;
	},

	// SET_SELECT_CATEGORY (state, action) {
  //   return state;
	// },
};

const formReducer = createReducer(initial_form, formHandlers);
