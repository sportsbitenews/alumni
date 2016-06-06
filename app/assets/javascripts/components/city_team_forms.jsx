var CityTeamForms = React.createClass({
  render: function() {
    return (
      <div>
        <h2 className="text-center">Teachers in {this.props.city.name}</h2>
        <CityTeacherList teachers={this.props.teachers} city={this.props.city.slug} role='teachers' />
        <h2 className="text-center">Beloved Teaching Assistants</h2>
        <CityTeachingAssistantList teaching_assistants={this.props.teaching_assistants} city={this.props.city.slug} role='teacher_assistant' />
      </div>
    )
  }
});
