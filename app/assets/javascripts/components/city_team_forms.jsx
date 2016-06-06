var CityTeamForms = React.createClass({
  render: function() {
    return (
      <div>
        <h2 className="text-center">Teachers in {this.props.city.name}</h2>
        <CityMembersList members={this.props.teachers} city={this.props.city.slug} role='teacher' />
        <h2 className="text-center">Beloved Teaching Assistants</h2>
        <CityMembersList members={this.props.teaching_assistants} city={this.props.city.slug} role='teacher_assistant' />
      </div>
    )
  }
});
