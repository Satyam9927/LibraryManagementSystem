import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet(urlPatterns = "/upload")
public class Upload extends HttpServlet {
    private static final long serialVersionUID = 1L;
    // location to store file uploaded
    private static final String UPLOAD_DIRECTORY = "image_upload";
    // upload settings
    private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50; // 50MB

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String Title=null;
        String ISBN=null;
        String Author=null;
        String Genre=null;
        String Description=null;
        int Availability=0;
        Date date = new Date();
        long added = date.getTime();
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // checks if the request actually contains upload file
        if (!ServletFileUpload.isMultipartContent(request)) {
            // if not, we stop here
            PrintWriter writer = response.getWriter();
            writer.println("Error: Form must has enctype=multipart/form-data.");
            writer.flush();
            return;
        }

        // configures upload settings
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // sets memory threshold - beyond which files are stored in disk
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        // sets temporary location to store files
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        ServletFileUpload upload = new ServletFileUpload(factory);

        // sets maximum size of upload file
        upload.setFileSizeMax(MAX_FILE_SIZE);

        // sets maximum size of request (include file + form data)
        upload.setSizeMax(MAX_REQUEST_SIZE);

        // constructs the directory path to store upload file
        // this path is relative to application's directory
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;

        // creates the directory if it does not exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        try {
            @SuppressWarnings("unchecked")
            List<FileItem> formItems = upload.parseRequest(request);
            String fileName1 = "";
            if (formItems != null && formItems.size() > 0) {
                for (FileItem item : formItems) {
                    // processes only fields that are not form fields
                    if (item.isFormField()) {
                        if(item.getFieldName().equals("Title")){
                            Title = StringEscapeUtils.escapeJava(item.getString());
                        }
                        if(item.getFieldName().equals("ISBN")){
                            ISBN = StringEscapeUtils.escapeHtml(item.getString());
                        }
                        if(item.getFieldName().equals("Author")){
                            Author = StringEscapeUtils.escapeHtml(item.getString());
                        }
                        if(item.getFieldName().equals("Genre")){
                            Genre = StringEscapeUtils.escapeHtml(item.getString());
                        }
                        if(item.getFieldName().equals("Description")){
                            Description = StringEscapeUtils.escapeJava(item.getString());
                        }
                        if(item.getFieldName().equals("Availability")){
                            Availability = Integer.parseInt(item.getString());
                        }
                    }
                    else{
                        String fileName = new File(item.getName()).getName();
                        fileName1 += fileName;
                        String filePath = uploadPath + File.separator + fileName;
                        File storeFile = new File("C:\\Users\\Babbar\\IdeaProjects\\LibraryManagementSystem\\web\\img\\" + ISBN + ".jpg");
                        // saves the file on disk
                        item.write(storeFile);
                    }
                }
            }
//            String p_text = request.getParameter("Title");
//            String gallery_nm = request.getParameter("upload_wall_gallery");
//            out.println(Title);
//            out.println("Upload has been done successfully!"+fileName1);
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","");
//            Statement stmt=conn.createStatement();
//            stmt.executeUpdate("INSERT INTO books values('" + ISBN + "','" + Title + "','" + Author + "','" + Genre + "','" + Description + "','" + Availability + "')");
//            conn.close();
            PreparedStatement stmt=conn.prepareStatement("INSERT INTO books values(?,?,?,?,?,?,?)");
            stmt.setString(1,ISBN);
            stmt.setString(2,Title);
            stmt.setString(3,Author);
            stmt.setString(4,Genre);
            stmt.setString(5,Description);
            stmt.setInt(6,Availability);
            stmt.setLong(7,added);
            stmt.executeUpdate();
            conn.close();

            response.sendRedirect("admin/addBooks.jsp");
        } catch (Exception ex) {
            out.println(ex.getMessage());
        }

    }

}
