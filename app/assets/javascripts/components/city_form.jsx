var CityForm = React.createClass({
  render: function() {
    return (
      <div className="container">
        <form action={Routes.city_path(this.props.city)} className="simple_form edit_city" id="edit_city" method="post">
          <input type="hidden" name="_method" value="patch" />
          <input type='hidden' name='authenticity_token' value={this.props.token} />
          <div className="form-group padded-1em">
            <CityFormSpecificsArea
                specifics={this.props.marketing_specifics}
                renderedContent='Nothing to preview.'
                area_name='city[marketing_specifics]'
                area_id='city_marketing_specifics'
                placeholder={this.props.placeholder}
                area_label='Marketing specifics'
            />
          </div>
          <hr />
          <div className="form-group">
            <CityFormSpecificsArea
                specifics={this.props.logistic_specifics}
                renderedContent='Nothing to preview.'
                area_name='city[logistic_specifics]'
                area_id='city_logistic_specifics'
                placeholder={this.props.placeholder}
                area_label='Logistic specifics'
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
