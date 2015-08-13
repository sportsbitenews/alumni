var PostList = React.createClass({
  render: function() {
    return (
      <div ref='postList'>
        <div className='col-sm-3 posts-column'>
        <a href={Routes.new_resource_path()}>
          <div className='posts-column-new'>
            ADD A NEW RESOURCE
          </div>
        </a>
          {this.props.resources.map(resource => {
            var props = _.merge(resource, { key: `${resource.type}-${resource.id}` });
            return React.createElement(ResourceListElement, props);
          })}
        </div>
        <div className='col-sm-3 posts-column'>
        <a href={Routes.new_question_path()}>
          <div className='posts-column-new'>
            ASK A NEW QUESTION
          </div>
        </a>
          {this.props.questions.map(question => {
            var props = _.merge(question, { key: `${question.type}-${question.id}` });
            return React.createElement(QuestionListElement, props);
          })}
        </div>
        <div className='col-sm-3 posts-column'>
          <a href={Routes.new_job_path()}>
            <div className='posts-column-new'>
              ADD A NEW JOB
            </div>
          </a>
          {this.props.jobs.map(job => {
            var props = _.merge(job, { key: `${job.type}-${job.id}` });
            return React.createElement(JobListElement, props);
          })}
        </div>
        <div className='col-sm-3 posts-column'>
          <div className='posts-column-new'>
            ADD A NEW MILESTONE
          </div>
        </div>
      </div>
    );
  }
});
