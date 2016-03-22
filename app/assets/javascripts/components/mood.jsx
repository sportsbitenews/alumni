var Mood = React.createClass({
  getInitialState: function() {
    return {
      content: this.props.mood
    };
  },

  render: function() {
    var mood = null;
    if (this.state.content) {
      var mood = (<p>{'"' + this.state.content + '"'}</p>);
    }
    return (<div>{mood}</div>);
  }
});
