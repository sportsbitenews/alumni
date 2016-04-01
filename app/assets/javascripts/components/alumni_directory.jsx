var AlumniDirectory = React.createClass({
  getInitialState: function() {
    return {
      alumni: this.props.users,
      index:  algoliasearch(
                this.props.algolia_application_id,
                this.props.algolia_search_only_api_key
              ).initIndex('AlumniDirectory')
     };
  },

  pushSearchResultToDirectory: function(result) {
    this.setState({alumni: result});
  },

  render: function() {
    return (
      <div className="directory">
        <AlumniSearch index={this.state.index} pushResult={this.pushSearchResultToDirectory} />
        <AlumniList users={this.state.alumni} />
      </div>
    );
  }
});
