# abap_undo_redo_handler

###Implement Text Editor Undo Redo features using ABAP.

Since this task, in different variations, is often present in coding interviews, I was interested in how it could be solved using ABAP.

The task. 

You have a set of events to perform. Once all events are performed, you should return to the current state the system should be in after all events are performed.

Events:
write - write the story (id, name) 
undo - reverses the most recent event
redo - redoes the most recent event undone 

Example.

Events = ( event = 'write' story =( 1 , 'My Strory 1'  )
		 event = 'write' story =( 2 , 'My Strory 2'  )
 		 event = 'undo'
 		 event = 'redo'
		 event = 'redo' )

Result = (2, My Strory 2 )

You can find the source code of the task on GitHub and download it for yourself. See link in first comment.
