class ArchivesSpaceService < Sinatra::Base

 Endpoint.get('/repositories/:repo_id/resources/:id/tree')
     .description("Get a Resource tree")
     .deprecated("Call the */tree/{root,waypoint,node} endpoints to traverse record trees." +
                "  See backend/app/model/large_tree.rb for further information.")
     .params(["id", :id],
             ["limit_to", String, "An Archival Object URI or 'root'", :optional => true],
             ["repo_id", :repo_id])
     .permissions([:view_repository])
     .returns([200, "OK"]) \
   do
     resource = Resource.get_or_die(params[:id])

     tree = if params[:limit_to] && !params[:limit_to].empty?
              if params[:limit_to] == "root"
                ao = :root
              else
                ref = JSONModel.parse_reference(params[:limit_to])

                if ref
                  ao = ArchivalObject[ref[:id]]
                else
                  raise BadParamsException.new(:limit_to => ["Invalid value"])
                end
              end

              resource.partial_tree(ao)
            else
              resource.tree
            end

     json_response(tree)
   end
end
