var CityForm = React.createClass({
  getInitialState: function() {
    return {
      preview: false,
      renderedContent: "Nothing to preview.",
      content: this.props.specifics
    }
  },
  render: function() {
    return (
      <div className="container padded">
        <form action="" className="simple_form edit_city" id="edit_city" method="post">
          <div className="form-group city_specifics text optional">
            <textarea name="city[specifics]" id="city_specifics" rows="20" className="text optional form-control" placeholder={this.props.placeholder} defaultValue={this.props.specifics} ></textarea>
          </div>
          <div className="text-right padded-1em form-group form-inline">
            <button className="btn btn-default button-discret form-control" onClick={this.onPreviewClick}>Preview</button>
            <input type="submit" className="btn btn-default button-discret form-control" value="Update" />
          </div>
        </form>
      </div>
    );
  },
  onPreviewClick(e) {
    e.preventDefault();
    this.setState({ preview: true })
    AnswerActions.preview(this.contentDOMNode().value);
  },
});
