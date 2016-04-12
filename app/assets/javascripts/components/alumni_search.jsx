var AlumniSearch = React.createClass({
  render: function() {
    return (
      <div className="row" id="alumni-directory-search">
        <div className="col-xs-10 col-xs-offset-2 col-sm-3 col-sm-offset-6 col-md-2 col-md-offset-10">
          <form action="" className="form-inline">
            <div className="form-group">
              <input className="form-control" id="directory_query" type="text" name="query" placeholder="name, company, batch,..." />
              <button className="btn btn-warning" type="submit"><i className="fa fa-search"></i></button>
            </div>
          </form>
        </div>
      </div>
    );
  }
});
