var CitySpecificsForm = React.createClass({
  getInitialState: function() {
    return {
      area_name: 'city[' + this.props.name + ']',
      area_id: 'city_' + this.props.name
    };
  },
  render: function() {
    return (
      <div className="container">
        <form action={Routes.city_path(this.props.city)} className="simple_form edit_city" id="edit_city" method="post">
          <input type="hidden" name="_method" value="patch" />
          <input type='hidden' name='authenticity_token' value={this.props.token} />
          <div className="form-group padded-1em">
            <CityFormSpecificsArea
                specifics={this.props.specifics}
                renderedContent='Nothing to preview.'
                area_name={this.state.area_name}
                area_id={this.state.area_id}
                placeholder={this.props.placeholder}
                area_label={this.props.area_label}
            />
          </div>
          <div className="padded-1em form-group">
            <input type="submit" className="btn btn-primary" value="Update" />
          </div>
        </form>
      </div>
    );
  },
});
