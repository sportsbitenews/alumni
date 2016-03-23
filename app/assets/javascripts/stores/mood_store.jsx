class MoodStoreClass {
  constructor() {
    this.updated_mood = null;

    this.bindListeners({
      updateUpdatedMood: UserActions.update_profile
    });
  }

  updateUpdatedMood(mood) {
    this.updated_mood = mood;
  }

  getUpdatedMood() {
    return this.updated_mood;
  }
}

var MoodStore = alt.createStore(MoodStoreClass, 'MoodStore');
