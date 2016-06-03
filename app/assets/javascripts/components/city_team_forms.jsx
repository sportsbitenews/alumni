var CityTeamForms = React.createClass({
  getInitialState: function() {
    return {
    };
  },
  render: function() {
    return (
      <div>
        <h2>Teachers in {this.props.city}</h2>
        <CityTeacherList teachers={this.props.teachers}/>
        <h2>Beloved Teaching Assistants</h2>
        <CityTeachingAssistantList tas={this.props.tas} />
      </div>
    )
  }
});
