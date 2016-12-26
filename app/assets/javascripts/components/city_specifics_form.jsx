var CitySpecificsForm = React.createClass({
  render: function() {
    return (
      <div className="container padded">
        <h2 className='text-center city-specifics-form-title'>{this.props.title}</h2>
        <form action={Routes.city_path(this.props.city)} className="simple_form edit_city" id="edit_city" method="post">
          <input type="hidden" name="_method" value="patch" />
          <input type='hidden' name='authenticity_token' value={this.props.token} />
          <div className="form-group">
            <CityFormSpecificsArea
                specifics={this.props.specifics}
                renderedContent='Nothing to preview.'
                area_name={'city[' + this.props.name + ']'}
                area_id={'city_' + this.props.name}
                placeholder={this.props.placeholder}
            />
          </div>
          assistant: Markdown supported
          <div className="padded-1em form-group">
            <input type="submit" className="btn btn-primary" value="Update" />
          </div>
        </form>
      </div>
    );
  },
});
