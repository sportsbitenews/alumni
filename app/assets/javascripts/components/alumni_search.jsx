var AlumniSearch = React.createClass({
  render: function() {
    return (
      <div className="row" id="alumni-directory-search">
        <div className="col-xs-10 col-xs-offset-2 col-sm-3 col-sm-offset-6 col-md-2 col-md-offset-10">
          <input className="form-control" onKeyDown={this.handleKeydown} id="directory_query" type="text" ref="query" placeholder="name, company, batch,..." />
        </div>
      </div>
    );
  },

  handleKeydown(e) {
    if (e.which == 13) {
      var query = React.findDOMNode(this.refs.query).value;
      console.log(query);
      this.props.index.search(query, {hitsPerPage: 20}, function(err, content) {
        console.log(content.hits);
      });
    }
  }
});
